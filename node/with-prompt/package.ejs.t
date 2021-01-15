---
to: <%= projectName || 'NodeApp' %>/package.json
---
{
  "name": "<%= projectName || 'NodeApp' %>",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "mquery": ">=3.2.3",
    "bcryptjs": "^2.4.3",
    "body-parser": "^1.19.0",
    "connect-mongo": "^3.2.0",
    "ejs": "^3.1.3",
    "express": "^4.17.1",
    "express-session": "^1.17.1",
    "jsonwebtoken": "^8.5.1",
    "lodash": "^4.17.20",
    "mongoose": "^5.9.20",
    "mongoose-timestamp": "^0.6.0",
    "nodemailer": "^6.4.10"
  }
}
