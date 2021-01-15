---
to: <%= projectName || 'NodeApp' %>/models/userCard.js
---
const mongoose = require('mongoose');
const mongooseTimeStamp = require('mongoose-timestamp');


const Schema = new mongoose.Schema({
    name: {
        fname: { type: String, required: true },
        lname: { type: String, required: true }
    },
    email: { type: String, required: true },
    user: { type: mongoose.Types.ObjectId, ref: 'User' }
});

Schema.plugin(mongooseTimeStamp);
const userCard = mongoose.model('UserCard', Schema);


module.exports = { userCard };
