// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//
module.exports = [
  {
    type: 'input',
    name: 'name',
    message: " request name ? ",
  }, {
  }, {
    type: 'input',
    name: 'method',
    message: "  Ex. POST GET ",
  }, {
    type: 'input',
    name: 'url',
    message: "  Request url ? ",
  }, {
    type: 'input',
    name: 'resType',
    message: "Response Data Type Ex. JSON",
  }, {
    type: 'input',
    name: 'reqType',
    message: "req data type Ex. application/json",
  }, {
    type: 'input',
    name: 'resName',
    message: "response name Ex. result",
  }

]
