---
to: <%= projectName || 'NodeApp' %>/routes/user.js 
---
const express = require('express');
const router = express.Router();
const controller = require('../controllers/user');
const viewsController = require('../controllers/userViews');
const tokenValidate = require('../token_validate');

//post request to register the user : 
router.post('/api/register', controller.register)
//post request to confirm user account: 
router.post('/api/confirm', controller.confirm)
//post request to login : 
router.post('/api/login', controller.login)
//get request to logout :
router.get('/api/logout', tokenValidate, controller.logout);
//get request to check user status  :
router.get('/api/status', controller.status);

/******************views routes ****************/
//login view
router.get('/login', viewsController.login);
//register view
router.get('/signup', viewsController.signup);
//confirmation view: 
router.get('/confirm', viewsController.confirmUser);


module.exports = router;