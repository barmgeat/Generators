---
to: routes/<%= name %>.js
---


const express = require('express');
const router = express.Router();
const controller = require('../controllers/<%= name %>');
const tokenValidate = require('../token_validate');


router.post('/add', tokenValidate, controller.add);
router.post('/edit', controller.edit);
router.get('/all', controller.getAll);
router.get('/id', controller.getById);
router.get('/delete', controller.deleteById);


module.exports = router;
