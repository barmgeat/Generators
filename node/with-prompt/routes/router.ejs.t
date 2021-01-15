---
to: <%= projectName || 'NodeApp' %>/routes/router.js
---
const express = require('express');
const router = express.Router();
const controller = require('../controllers/controller');
const tokenValidate = require('../token_validate');

//index page:
router.get('/', controller.index);


module.exports = router;
