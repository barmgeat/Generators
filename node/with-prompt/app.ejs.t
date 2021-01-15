---
to: <%= projectName || 'NodeApp' %>/app.js
---
const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const userRoute = require('./routes/user');
const appRouter = require('./routes/router');
const session = require('express-session');
const MongoStore = require('connect-mongo')(session);
let sessionStore;

/***
vars names
 * 1: mongoUserName <%= mongoUserName || 'mustafa' %> 
 * 2: mongoPass <%= mongoPass || 'BeIp42TaLo3Ydkxv' %>
 * 3: db <%= db || 'Dev' %>
 <% if (uri) { %> 
 * 4: uri: <%= uri %>
 <% } else { %>
 * 4: uri: 'mongodb+srv://' + mongoUserName  + ':' + mongoPass + '@cluster0.t3yci.mongodb.net/' + db + '?retryWrites=true&w=majority'
 <% } %>
 * 5: port <%= port || '3000' %>
 * 6: origin <%= origin || true %>
 */

 
const mongoUserName = '<%= mongoUserName || 'mustafa' %>';
const mongoPass = '<%= mongoPass || 'BeIp42TaLo3Ydkxv' %>';
const db = '<%= db || 'Dev' %>';

const app = express();

//connect to the database: 
 <% if (uri) { %> 
const uri = <%= uri %>
 <% } else { %>
const uri = 'mongodb+srv://' + mongoUserName  + ':' + mongoPass + '@cluster0.t3yci.mongodb.net/' + db + '?retryWrites=true&w=majority'
 <% } %>
try {
    mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });
    console.log('connected to the database');
    //link mongo store with mongo db: 
    sessionStore = new MongoStore({
        mongooseConnection: mongoose.connection,
        collection: 'sessions'
    })
} catch (error) {
    console.log(error);
}
const port = process.env.PORT || <%= port || '3000' %>
app.listen(port);
console.log('server start at port ' + port);

//user express session: 
app.use(session({
    secret: 'random session secret',
    resave: false,
    saveUninitialized: true,
    store: sessionStore,
    cookie: {
        maxAge: 1 * (24 * 3600 * 1000), // 1day 24hours 3600sec 1000millSec
    }
}));

<% if( origin || 'true' == 'true' ) { %>
//allow origin from other sites : 
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
})
<% } %>

//use body-parser:
app.use(bodyParser.json());
//set view engine:
app.set('view engine', 'ejs');
//set public folder:
app.use(express.static('public'));

//users route: 
app.use('/user', userRoute);
//app router
app.use('/', appRouter);

