/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function mostrarMensajeError(inputElement, message) {
    inputElement.classList.add("formulario_mensaje-error");
    inputElement.parentElement.querySelector(".formulario_mensaje-error-entrada").textContent = message;
}

function quitarMensajeError(inputElement) {
    inputElement.classList.remove("formulario_mensaje-error-entrada");
    inputElement.parentElement.querySelector(".formulario_mensaje-error-entrada").textContent = "";
}

function nombreValido(destino) {
    nombreP = document.querySelector("#nombreP").value;
    $.ajax({
        url: '/Bar/agregarProducto/comprobar' + destino,
        type: 'POST',
        data: {nombre: nombreP},
        success: function (resultText) {
            const mess = document.getElementById("mensajeNombreExistente").innerHTML = resultText;
        },
        error: function (jqXHR, exception) {
            console.log('Error!!');

        }
    });


}

function validarFormularioCrearProducto(evento) {

    if (window.history.replaceState) { // verificamos disponibilidad
        window.history.replaceState(null, null, window.location.href);
    }

//    evento.preventDefault();


    let comprobacionNombre = document.getElementById('mensajeNombreExistente');
    console.log(comprobacionNombre);
    if (comprobacionNombre.innerText.length > 0) {
        console.log('ya existe');
        return;
    }

    var nombre = document.getElementById('nombreP');
    if (nombre.value.length == 0) {
        mostrarMensajeError(nombre, "Nombre en blanco");
        return;
    }
    quitarMensajeError(nombre);

    var precio = document.getElementById('precioP');
    if (precio.value.length == 0) {
        mostrarMensajeError(precio, "Precio en blanco");
        return;
    }
    quitarMensajeError(precio);

    var descripcion = document.getElementById('descripcionP');
    if (descripcion.value.length == 0) {
        mostrarMensajeError(descripcion, "Descripcion en blanco");
        return;
    }
    quitarMensajeError(descripcion);



//    this.submit();
}




document.addEventListener("DOMContentLoaded", () => {

    document.getElementById("formulario-producto").addEventListener('submit', validarFormularioCrearProducto);


});