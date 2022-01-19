



function correoValido() {
    correoUsuario = document.querySelector("#direccionUsuario").value;
    $.ajax({
        url: '/Bar/login/comprobar',
        type: 'POST',
        data: {correo: correoUsuario},
        success: function (resultText) {
            const mess = document.getElementById("mensajeCorreoExistente");
            mess.innerHTML = resultText;
        },
        error: function (jqXHR, exception) {
            console.log('Error!!');

        }
    });


}

function mandarMensaje(formElement, type, message) {
    const messageElement = formElement.querySelector(".formulario_mensaje");

    messageElement.textContent = message;
    messageElement.classList.remove("formulario_mensaje-correcto", "formulario_mensaje-error");
    messageElement.classList.add(`formulario_mensaje-${type}`);
}

function mostrarMensajeError(inputElement, message) {
    inputElement.classList.add("formulario_mensaje-error");
    inputElement.parentElement.querySelector(".formulario_mensaje-error-entrada").textContent = message;
}

function quitarMensajeError(inputElement) {
    inputElement.classList.remove("formulario_mensaje-error-entrada");
    inputElement.parentElement.querySelector(".formulario_mensaje-error-entrada").textContent = "";
}


function validarNombreCorreo() {
    nombreUsuario = document.getElementById("nombreUsuario").value;
    direccionUsuario = document.getElementById('direccionUsuario').value;
    passSegunda = document.getElementById('passwordSegunda').value;

    correcto = true;

    if (nombreUsuario.length < 1) {
        mostrarMensajeError(passwordSegunda, "Nombre obligatorio");
        correcto = false;
    }

    if (direccionUsuario.length < 1) {
        mostrarMensajeError(passwordSegunda, "Correo obligatorio");
        correcto = fasle;
    }

    if (correcto) {
        quitarMensajeError(passwordSegunda);
    }


}



function ValidarContraseñaiguales() {

    const formularioCrearCuenta = document.querySelector("#CrearCuenta");

    passSegunda = document.getElementById('passwordSegunda');
    passPrimera = document.getElementById('passwordPrimera');


    if (passPrimera.value == "" || passSegunda.value == "") {
        mostrarMensajeError(passwordSegunda, "Las contraseñas estan en blanco");
        return false;
    }


    if (passPrimera.value.length == passSegunda.value.length && passPrimera.value == passSegunda.value) {
        // mandarMensaje(formularioCrearCuenta, "error", "Usuario o contraseña vacios");
        quitarMensajeError(passwordSegunda);
        return true;
    } else {
        mostrarMensajeError(passwordSegunda, "Las contraseñas no coinciden");

        return false;
    }

}

function validarFormularioLogin(evento) {
    //comprobamos que no sean empty
    evento.preventDefault();
    var usuario = document.getElementById('nombreUsuarioLogin').value;
    if (usuario.length == 0) {
        alert('No has escrito nada en el usuario');
        return;
    }
    var pass = document.getElementById('passwordLogin').value;
    if (pass.length == 0) {
        alert('Contrseña vacia');
        return;
    }
    this.submit();

}

function validarFormularioCreacionCuenta(evento) {
    //comprobamos que no sean empty
    evento.preventDefault();

    let comprobacionCorreo = document.getElementById('mensajeCorreoExistente');
    if (comprobacionCorreo.innerText.length > 0) {
        return;
    }

    var usuario = document.getElementById('nombreUsuario');
    if (usuario.value.length == 0) {
        mostrarMensajeError(usuario, "Nombre en blanco");
        return;
    }

    var correo = document.getElementById('direccionUsuario');
    if (correo.value.length == 0) {
        mostrarMensajeError(correo, "Correo en blanco");
        return;
    }


    if (!ValidarContraseñaiguales()) {
        return;
    }
    this.submit();

}

function eliminarMensajesErrores() {
//    evento.preventDefault();
    var usuario = document.getElementById('nombreUsuario');
    if (usuario.value.length != 0) {
        quitarMensajeError(usuario);
    }
    var correo = document.getElementById('direccionUsuario');
    if (correo.value.length != 0) {
        quitarMensajeError(correo);
    }



}


document.addEventListener("DOMContentLoaded", () => {
    const formularioAcceso = document.querySelector("#Acceso");
    const formularioCrearCuenta = document.querySelector("#CrearCuenta");
    document.querySelector("#enlaceCrearCuenta").addEventListener("click", e => {
        e.preventDefault();
        formularioAcceso.classList.add("formulario_oculto");
        formularioCrearCuenta.classList.remove("formulario_oculto");
    });
    document.querySelector("#EnlaceAcceso").addEventListener("click", e => {
        e.preventDefault();
        formularioAcceso.classList.remove("formulario_oculto");
        formularioCrearCuenta.classList.add("formulario_oculto");
    });

    document.getElementById("Acceso").addEventListener('submit', validarFormularioLogin);
    document.getElementById("CrearCuenta").addEventListener('submit', validarFormularioCreacionCuenta);


});


//document.addEventListener("DOMContentLoaded", init, true);
//
//function init() {
//    document.querySelector("#botonLog").addEventListener("click", handleLogin, true);
//    function handleLogin(e) {
//        e.preventDefault();
//        var txtUsername = document.querySelector("#nombreUsuarioLogin");
//        var txtPassword = document.
//        querySelector("#passwordUsuarioLogin");
//        var userdata = '{"username":' + txtUsername.value + ',"password":' + txtPassword.value + '}';
//        loginByAjax(userdata);
//        resetForm();
//    }
//
//
//    function loginByAjax(datos) {
//        var request = new XMLHttpRequest();
//        request.open("POST", "/login/Acceder", true);
//        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
//        request.onreadystatechange = funtion()
//        {
////si exito en respuesta
//            if (request.readyState === 4 && request.status === 200) {
//                var mensaje = request.responseText;
//                alert(mensaje);
//            } else if (request.readyState === 4 && request.status !== 200) {
//                var mensaje = request.responseText;
//                alert(mensaje);
//            }
//        }
//        ;
//        request.send("userdata=" + datos);
//    }
//
//}







