// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//

/***
vars names
 * projectName : project name 
 * 1: mongoUserName 
 * 2: mongoPass
 * 3: db
 * 4: uri
 * 5: port
 * 6: origin
 */
module.exports = [
  {
    type: 'input',
    name: 'projectName',
    message: "Project Name Def: NodeApp"
  },
  {
    type: 'input',
    name: 'baseUrl',
    message: "base app url Def: http://localhost:300/"
  },
  {
    type: 'input',
    name: 'mongoUserName',
    message: "Mongo DB User Name def: mustafa "
  },{
    type: 'input',
    name: 'mongoPass',
    message: "Mongo DB password def: stored for Me 4 Life "
  },{
    type: 'input',
    name: 'db',
    message: "Mongo DB Name def: Dev "
  },{
    type: 'input',
    name: 'uri',
    message: "Mongo DB Uri: you can find it from the Mongo Web Site and then Cluster connect. "
  },{
    type: 'input',
    name: 'port',
    message: "Node Server Port Def: 3000"
  },{
    type: 'input',
    name: 'origin',
    message: "allow access to server from other origins: Def: true"
  
  }
]
