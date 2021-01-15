---
inject: true
to: generated/data.js
prepend: true
---
//<%= name %>
const <%= name %> = $('<<%= type || 'div' %>>', {
    class: classPre + '<%= name || name %>',
    id: idPre + '<%= h.capitalize(name) || name %>',
})
