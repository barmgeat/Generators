---
to: <%= projectName || 'NodeApp' %>/public/confirmUser.js
---
$(document).ready(() => {
    const form = $('#form');
    form.on('submit', (e) => {
        const code = $('#code').val();
        const id = getUrlParameter('id');

        const data = JSON.stringify({code, id});
        const method = 'POST'; // HTTP Request Type
        const url = <%= baseUrl + 'user/api/confirm' || 'http://localhost:3000/user/api/confirm' %> ; // url
        const contentType = 'application/json'; //content type
        const dataType = 'JSON' //response Data
        const success = (res) => {
            if (res.errMsg) {
                $('#error').text(res.errMsg)
                setTimeout(() => {
                    $('#error').text('')
                }, 3000);
                return;
            }
            window.location.href = '/';
        }
        //send ajax : 
        $.ajax({ method,  contentType, url, data, success, dataType })

        e.preventDefault();
    })
})

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};