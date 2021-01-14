const example = {
    PrimaryID: 'mySection',
    PrimaryClass: 'my-section',
    Objects: [{
        type: 's',
        name: 'userContainer',
        children: [{
            name: 'header',
            type: 'div',
            children: [{
                name: 'NameContainer',
                type: 'div',
                children: [{
                    name: 'fname',
                    type: 'span',
                }, {
                    name: 'lname',
                    type: 'span',
                }]
            }, {
                name: 'TimeContainer',
                type: 'div',
            },]
        }, {
            name: 'body',
            type: 'div',
            children: [{
                name: 'bio',
                type: 'div'
            }, {
                name: 'description',
                type: 'div',
                children: [{
                    name: 'friends',
                    type: 'div',
                    children: [{
                        name: 'friendsCount',
                        type: 'div'
                    }, {
                        name: 'friendsContainer',
                        type: 'div',
                        children: [{
                            name: 'friendContainer',
                            type: 'div',
                            children: [{
                                name: 'friendHeader',
                                type: 'div',
                                children: [{
                                    name: 'name',
                                    type: 'div',
                                    children: [{
                                        name: 'fname',
                                        type: 'span'
                                    }, {
                                        name: 'lname',
                                        type: 'span'
                                    }]
                                }]
                            }, {
                                name: 'friendBody',
                                type: 'div'
                            }]
                        }]
                    }]
                }]
            }
            ]
        }, {
            name: 'footer',
            type: 'div',
        },]
    }]
}


$(document).ready(() => {

    const result = nestedComponents(example);
    result.forEach(obj => {
        $('#content').text($('#content').text() + obj)
    });
    createBluePrint(example.Objects, $('#bluePrint'))
})

function createBluePrint(data, parent) {
    //loop throw each component : 
    for (let i = 0; i < data.length; i++) {
        const obj = data[i];
        const container = $('<div>', {id: 't' + i}).text(obj.name);
        container.click((e) => {
            e.stopPropagation();
            container.children().toggle()
        })
        container.css('padding',  '4px 16px')
        parent.append(container);
        if (obj.children && obj.children.length > 0) {
            createBluePrint(obj.children, container)
        }
        container.children().hide()
    }
}

const nestedComponents = (data) => {
    //store primary HTML ID : 
    const pID = data.PrimaryID;
    // store Primary CSS Class . 
    const pClass = data.PrimaryClass;
    // extract Primary Objects :
    const pObjects = data.Objects;
    // JQuery Objects Array: 
    const jQueryObjs = new Array()
    JQueryObjs = extractObjects(pObjects, pID, pClass, jQueryObjs);

    return JQueryObjs;
}


function extractObjects(objects, _ID, _Class, store, parent) {
    parent ? parent = parent : parent = 'root';
    objects.forEach(obj => {
        //  extract Obj type:
        let type;
        obj.type ? type = obj.type : type = 'div'
        //  extract Obj name:
        const name = obj.name;
        //  extract Obj custom class
        let classes;
        obj.classes ? classes = obj.classes : classes = ''
        // extract Obj Text 
        let text;
        obj.text ? text = obj.text : text = ''
        const componentData = { _ID, name, type, classes, _Class, text, parent }
        let object;
        //  JQuery hidden Object 
        if (obj.hidden) {
            object = createHiddenComponent(componentData)
        } else {
            object = createNormalComponent(componentData)
        }
        //  push Obj to JQuery Objects Array
        store.push(object)
        //  check if the Obj has Children
        if (obj.children && obj.children.length > 0) {
            extractObjects(obj.children, _ID, _Class, store, name)
        }
    });

    return store;
}

function createHiddenComponent(data) {
    return `const ${data.name} = $('< ${data.type} >', {
    class: '${data._Class} ${data._Class}-${data.name} ${data.classes}',
    id: '${data._ID}${data.name}',
    text: '${data.text}'
}).appendTo(${data.parent}).hide()`
}


function createNormalComponent(data) {
    return `
const ${data.name} = $('<` + data.type + `>', {
    class: '${data._Class} ${data._Class}-${data.name} ${data.classes}',
    id: '${data._ID}${data.name}',
    text: '${data.text}'
}).appendTo(${data.parent})

`
}





