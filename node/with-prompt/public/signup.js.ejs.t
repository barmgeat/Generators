---
to: <%= projectName || 'NodeApp' %>/public/signup.js
---
$(document).ready(() => {
    const form = $('#form');
    form.on('submit', (e) => {
        const fname = $('#fname').val();
        const lname = $('#lname').val();
        const password = $('#password').val();
        const email = $('#email').val();

        //check inputs: 
        if (fname.length < 3 || lname.length < 3 || password.length < 3 || email.length < 5) {
            $('#error').text('information error .');
            setTimeout(() => {
                $('#error').text('')
            }, 3000);
            e.preventDefault()
            return;
        }
        
        const data = JSON.stringify({ fname, lname, password, email })
        
        const method = 'POST'; // HTTP Request Type
        const url = <%= baseUrl + 'user/api/register' || 'http://localhost:3000/user/api/register' %>; // url
        const contentType = 'application/json'; //content type
        const dataType = 'JSON' //response Data
        const success = (res) => {
            if (res.error) {
                $('#error').text(res.error)
                setTimeout(() => {
                    $('#error').text('')
                }, 3000);
            }
            if (res.codeMailed) {
                window.location.href = '/user/confirm?id=' + res.userCard.user
            }
        }
        //send ajax : 
        $.ajax({ method, contentType, url, data, success, dataType })


        e.preventDefault();
    })
})