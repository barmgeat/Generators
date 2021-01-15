---
to: <%= projectName || 'NodeApp' %>/controllers/user.js
---
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const _ = require('lodash');

let secret = 'randomPassword'

//import models : 
const mUser = require('../models/user').user;
const mUserCard = require('../models/userCard').userCard;

//Register
const register = ('/register', async (req, res) => {
    let userId, userCardId;
    try {

        //check the information: 
        if (
            !req.body.email ||
            !req.body.fname ||
            !req.body.lname ||
            !req.body.password
        )
            throw ({ error: 'need more information about the user' });

        //check if the user already registered  , 
        const userRegisteredByEmail = await mUser.findOne({ email: req.body.email });
        if (userRegisteredByEmail) { res.json({ error: 'already registered' }); return; }

        //crypt the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(req.body.password, salt);

        //user obj: 
        const user = new mUser({
            email: req.body.email,
            password: hashedPassword,
            code: _.random(99999, 999999)
        });

        //user card obj
        const userCard = new mUserCard({
            name: {
                fname: req.body.fname,
                lname: req.body.lname
            },
            email: req.body.email,
            user: user._id
        })

        //link user with userCard: 
        user.userCard = userCard;

        //save the user userCard to the database 
        userId = user._id;
        userCardId = userCard._id;
        await user.save();
        await userCard.save();

        await sendConfirmationEmail(user);

        res.json({ userCard, codeMailed: true });
    } catch (err) {
        try {
            //check if the user or the user card has saved to the database: 
            const user = await mUser.findById(userId);
            const userCard = await mUserCard.findById(userCardId);
            if (user) await user.remove();
            if (userCard) await userCard.remove();
        } catch (error) {
            res.json({ errMsg: 'unknown error', error })
        }
        res.json({ errMsg: 'user cant be registered', err });
    }

});

async function sendConfirmationEmail(user) {
    // create reusable transporter object using the default SMTP transport
    let transporter = nodemailer.createTransport({
        host: "smtp-relay.sendinblue.com",
        port: 587,
        secure: false,
        auth: {
            user: 'hazim6163@gmail.com',
            pass: 'GLjYqUg1r5DEQy8f',
        },
    });

    // send mail with defined transport object
    let info = await transporter.sendMail({
        from: '"Programming | register" <no-replay@programming.com>', // sender address
        to: user.email,
        subject: "confirmation", // Subject line
        html: "<b>confirmation code: </b>" + user.code, // html body
    });

    if (!info.messageId) throw ({ error: 'confirmation email cant be send' });
}


const confirm = ('/confirm', async (req, res) => {
    try {

        //check if the request has the user id and the code: 
        if (!req.body.id || !req.body.code) throw ({ error: 'need more information' });

        const userCard = await mUserCard.findOne({ user: req.body.id })
        if (!userCard) throw ({ error: 'user cant be found' });
        const user = await mUser.findById(userCard.user);
        if (!user) throw ({ error: 'user cant be found' });
        //check if the user already verified : 
        if (user.verified) throw ({ error: 'user already verified' })
        //check code : 
        if (user.code != req.body.code) throw ({ error: 'wrong code check it again' });
        //user confirmed: 
        user.verified = true;
        await user.save();

        //extract the token:
        var token = jwt.sign({ id: user._id }, secret);
        req.session.token = token;
        req.session.userCard = userCard;
        res.json({ userCard, confirmed: true })
    } catch (error) {
        res.json({ errMsg: 'confirmation failed', error, confirmed: false })
    }
})


//Login: 
const login = ('/login', async (req, res) => {
    try {

        //check if the user logged in : 
        if (req.session && req.session.token) throw ({ error: 'user already logged in', token: req.session.token })

        //check email and password: 
        if (!req.body.email || !req.body.password) throw ({ error: 'need more info' });

        //try to find the user in the database
        const user = await mUser.findOne({ email: req.body.email }).populate('userCard');
        if (!user) {
            res.json({ error: 'user can\'t be found.' });
            return;
        }
        const hashedPassword = user.password;
        passed = await bcrypt.compare(req.body.password, hashedPassword);
        if (!passed) {
            res.json({ error: 'incorrect password' });
            return;
        }

        //check if the user already verified
        if (!user.verified) throw ({ error: 'account need to be verified to login', id: user._id })
        // setting up the token for the login
        var token = jwt.sign({ id: user._id }, secret);
        req.session.token = token;
        req.session.userCard = user.userCard

        res.json({ token: token, userCard: user.userCard, loggedIn: true });
    } catch (error) {
        res.json({ errMsg: 'cant be logged in', error })
    }


})

//logout: 
const logout = async (req, res) => {
    try {
        if (req.session && req.session.token) {
            req.session.token = undefined;
            req.session.userCard = undefined;
            res.redirect('/');
            return
        }
        res.redirect('/')
    }
    catch (error) {
        res.json({ error: 'unknown error' })
    }
}

//check user status and get information about it : 
const status = async (req, res) => {
    try {
        const json = new Object();
        //check if the user have session: 
        if (req.session) json.session = true
        if (req.session.token) json.token = req.session.token;
        if (req.session.userCard) json.userCard = req.session.userCard;
        if (req.session.token) json.loggedIn = true;
        else json.loggedIn = false;
        res.json(json);
    } catch (error) {
        res.json({ error, errMsg: 'something wrong' }).status(400);
    }
}

module.exports = {
    register,
    login,
    logout,
    confirm,
    status,

};