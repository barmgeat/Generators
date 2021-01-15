---
to: <%= projectName || 'NodeApp' %>/public/main.css
---
body, html{
    margin: 0px;
    padding: 0px;
}

button{
    outline:none !important;
}
 
body{
    /*min-height: 100vh;TODO 8. set web page font*/
    font-family:'Roboto', sans-serif;
}

.pageWrapper{
  min-height: 83vh;
}

/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}