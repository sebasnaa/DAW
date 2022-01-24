/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function actualizarBebida(nombreOriginal, nombreBusqueda) {

    console.log(nombreOriginal);
    const nombreMod = document.querySelector('.nombreProductoEditar_' + nombreBusqueda).value;
    const precioMod = document.querySelector('.precioProductoEditar_' + nombreBusqueda).value;
    const desMod = document.querySelector('.descProductoEditar_' + nombreBusqueda).value;




    $.ajax({
        url: '/Bar/agregarProducto/bebida',
        type: 'POST',
        data: {nombreOriginal: nombreOriginal, nombreMod: nombreMod, precioMod: precioMod, desMod: desMod},
        success: function (resultText) {
//                            const mess = document.getElementById("mensajeCorreoExistente");
//                            mess.innerHTML = resultText;
        },
        error: function (jqXHR, exception) {
            console.log('Error!!');

        }
    });


}


