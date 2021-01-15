---
to: <%= projectName || 'NodeApp' %>/controllers/userViews.js
---
const login = (req, res) => {
    //check if the user already logged in 
    if (req.session && req.session.token && req.session.userCard) {
        res.redirect('/');
        return;
    }
    //render login page: 
    res.render('user/login', { title: 'Login', loggedIn: false });
}

const signup = async (req, res) => {
    //check if the user already logged in 
    if (req.session && req.session.token && req.session.userCard) {
        res.redirect('/');
        return;
    }
    //render signup page: 
    res.render('user/signup', { title: 'Signup', loggedIn: false });
}

const confirmUser = async (req, res) => {
    //check if the user already logged in 
    if (req.session && req.session.token && req.session.userCard) {
        res.redirect('/');
        return;
    }
    //render signup page: 
    res.render('user/confirmation', { title: 'confirmation', loggedIn: false });
}

module.exports = {
    login,
    signup,
    confirmUser
}
