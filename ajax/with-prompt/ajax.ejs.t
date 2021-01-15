---
to: generated/AJAX.w<%= name %>.js
---

// async request : 
async function <%= name %>(data){
    const <%= resName %> = await <%= name %>Async(data);
    return <%= resName %>
}

const <%= name %>Async = (data) => {
    return new Promise(resolve => {
        //send ajax : 
        $.ajax({ 
            method = '<%= method.toUpperCase() %>', // HTTP Request Type  contentType = '<%= reqType %>', // request content type, 
            url = '<%= url %>', // url
            data, // request Data
            success = (<%= resName %>) => {
                resolve(<%= resName %>)
            }, 
            dataType = '<%= resType %>' })
    });
}

