/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */





var xhr;

function init_ajax() {
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }

}

function leerDato() {

    init_ajax();

    var url = "http://localhost:8080/Bar/login/Acceder";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = mostrarDatos;

    var n = document.getElementById("nombreUsuarioLogin");
    var datos = "nombre=" + encodeURIComponent(n.value);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);

}

function mostrarDatos() {
    if (xhr.readyState === 4) {
        if (xhr.status === 200) {
            document.getElementById("nombreUsuarioLogin").innerHTML = xhr.responseText;
        }
    }

}





