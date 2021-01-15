---
to: <%= projectName || 'NodeApp' %>/models/user.js
---
const mongoose = require('mongoose');
const mongooseTimeStamp = require('mongoose-timestamp');


const Schema = new mongoose.Schema({
    email: { type: String, required: true },
    password: { type: String, required: true },
    verified: { type: Boolean, default: false },
    code: { type: Number, default: 0 },
    userCard: { type: mongoose.Types.ObjectId, ref: 'UserCard' }
});

Schema.plugin(mongooseTimeStamp);
const user = mongoose.model('User', Schema);


module.exports = { user };
