---
to: <%= projectName || 'NodeApp' %>/public/login.js
---
$(document).ready(() => {
    const form = $('#form');
    form.on('submit', (e) => {
        const email = $('#email').val();
        const password = $('#password').val();

        const data = JSON.stringify({ email, password });
        const method = 'POST'; // HTTP Request Type
        const url = <%= baseUrl + 'user/api/login' || 'http://localhost:3000/user/api/login' %>; // url
        const contentType = 'application/json'; //content type
        const dataType = 'JSON' //response Data
        const success = (res) => {
            console.log(res);
            if (res.loggedIn) {
                window.location.replace('/');
                return;
            }
            if (res.error) {
                $('#error').text(res.error)
                setTimeout(() => {
                    $('#error').text('')
                }, 3000);
            }
            if (res.errMsg) {
                $('#error').text(res.error.error);
                setTimeout(() => {
                    $('#error').text('')
                }, 3000);
            }
            //user need to confirm the account:
            if (res.error && res.error.id) {
                window.location.replace('/user/confirm?id=' + res.error.id);
                return;
            }
            if (res.errMsg) {
                if (res.error.token)
                    window.location.href = '/';
                return;
            }
        }
        //send ajax : 
        $.ajax({ method, contentType, url, data, success, dataType })

        e.preventDefault();
    })
})