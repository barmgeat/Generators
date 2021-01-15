---
to: <%= projectName || 'NodeApp' %>/controllers/controller.js
---
const index = async (req, res) => {
    if (!req.session || !req.session.userCard) {
        res.redirect('/user/login');
        return;
    }
    res.render('index', { title: '<%= projectName || 'NodeApp' %>', userCard: req.session.userCard, loggedIn: true})
}


module.exports = {
    index
}
