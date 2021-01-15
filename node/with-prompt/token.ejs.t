---
to: <%= projectName || 'NodeApp' %>/token_validate.js
---
const jwt = require('jsonwebtoken');
let secret = 'randomPassword'

// verify a token
const verifyToken = (req, res, next) => {
    try {
        if (!req.session || !req.session.token) {
            return res.status(401).json({ error: 'Access Denied' });
        }
        let token = req.session.token
        const verify = jwt.verify(token, secret);
        req.user = verify;
        next();
    } catch (err) {
        //TODO redirect to the error page
        res.status(403).json({ error: 'invalid token' });
    }
}

module.exports = verifyToken;
