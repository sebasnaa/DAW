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

function nombreValido() {
    nombreP = document.querySelector("#nombreP").value;
    $.ajax({
        url: '/Bar/agregarProducto/bebida',
        type: 'POST',
        data: {nombre: nombreP},
        success: function (resultText) {
            const mess = document.getElementById("mensajeNombreExistente");
            mess.innerHTML = resultText;
            mess.innerHTML = 'hola sebas';

        },
        error: function (jqXHR, exception) {
            console.log('Error!!');

        }
    });


}

function validarFormularioCrearProducto(evento){
    
     evento.preventDefault();
    
    let comprobacionNombre = document.getElementById('mensajeNombreExistente');
    if (comprobacionNombre.innerText.length > 0) {
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

    
    
    this.submit();
}




document.addEventListener("DOMContentLoaded", () => {

    document.getElementById("formulario-producto").addEventListener('submit', validarFormularioCrearProducto);


});