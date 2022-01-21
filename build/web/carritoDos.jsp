

<%@page import="java.sql.Array"%>
<%@page import="com.sun.xml.rpc.processor.modeler.nometadata.NoMetadataModeler"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="beans.Bebida"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <script>

            document.addEventListener('DOMContentLoaded', () => {

//                let carrito = [
//                    {
//                        nombre: 'Agua',
//                        precio: 1,
//                        imagen: 'Agua.jpg'
//                    },
//                    {
//                        nombre: 'Agua',
//                        precio: 1,
//                        imagen: 'Agua.jpg'
//                    }
//                ];
                let carrito = [];

                const DOMcarrito = document.querySelector('#elementos-menu');
                const DOMcontenedorProductos = document.getElementById('elementos-menu');

                function renderizarCarrito() {

//                    DOMcarrito.textContent = "";

                    const nombreP = carrito.map(n => n.nombre);
                    const carritoFiltrado = carrito.filter(({nombre}, indice) => !nombreP.includes(nombre, indice + 1));

                    carritoFiltrado.forEach((producto) => {

                        let contadorProducto = 0;
                        for (i = 0; i < carrito.length; i++) {
                            if (carrito[i].nombre == producto.nombre) {
                                contadorProducto = contadorProducto + 1;
                            }
                        }

                        const nodoItemMenu = document.createElement("div");
                        nodoItemMenu.classList.add('item-menu');
                        const nodoItemMenuDescripcion = document.createElement("div");
                        nodoItemMenuDescripcion.classList.add('item-menu-descripcion');
                        const nodoImagen = document.createElement("img");
                        let nombreImagen = producto.nombre;
                        nombreImagen = nombreImagen.replaceAll(' ', '');
                        nodoImagen.src = "images/productos/" + nombreImagen + ".jpg";
                        nodoImagen.classList.add('item-menu-image');
                        const nodoNombre = document.createElement("span");
                        nodoNombre.classList.add('menu-item-nombre');
                        nodoNombre.textContent = producto.nombre;
                        const nodoPrecio = document.createElement("span");
                        nodoPrecio.classList.add('menu-item-precio');
                        nodoPrecio.textContent = producto.precio + '€';
                        const nodoContador = document.createElement("span");
                        nodoContador.classList.add('menu-count-items');
                        nodoContador.textContent = ' x ' + contadorProducto;

                        const nodoBoton = document.createElement("button");
                        const nombrep = '' + nombreImagen;
                        nodoBoton.onclick = function () {
                            borrarProducto(nombrep, contadorProducto);
                        };
                        nodoBoton.classList.add('boton_x', nombrep);
                        nodoBoton.textContent = 'X';

                        DOMcarrito.appendChild(nodoItemMenu);
                        nodoItemMenu.appendChild(nodoItemMenuDescripcion);
                        nodoItemMenuDescripcion.appendChild(nodoImagen);
                        nodoItemMenuDescripcion.appendChild(nodoNombre);
                        nodoItemMenuDescripcion.appendChild(nodoPrecio);
                        nodoItemMenuDescripcion.appendChild(nodoContador);
                        nodoItemMenu.appendChild(nodoBoton);



                    });
                    let total = calcularTotal();
                    const nodoprecioTotal = document.createElement("p");
                    nodoprecioTotal.classList.add('precio-total');
                    nodoprecioTotal.textContent = 'Total cuenta: ' + total;
                    DOMcarrito.appendChild(nodoprecioTotal);
                    
                    

                }

                function cargarCarritoDeLocalStorage() {
                    // ¿Existe un carrito previo guardado en LocalStorage?
                    if (localStorage.getItem('carrito') !== null) {
                        // Carga la información
                        carrito = JSON.parse(localStorage.getItem('carrito'));
                    }
                }

                function round(num) {
                    var m = Number((Math.abs(num) * 100).toPrecision(15));
                    return Math.round(m) / 100 * Math.sign(num);
                }

                function calcularTotal() {

                    total = 0;
                    for (i = 0; i < carrito.length; i++) {
                        total += parseInt(carrito[i].precio);
                    }
                    total = round(total * 1.2);
                    return total;
                }

                function borrarProducto(nombreImagen, contadorProducto) {
                    if (contadorProducto < 2) {

                        for (i = 0; i < carrito.length; i++) {
                            let aux = carrito[i].nombre;
                            aux = aux.replaceAll(' ', '');
                            if (aux === nombreImagen) {
                                carrito.splice(i, 1);
                            }
                        }

                        localStorage.setItem("carrito", JSON.stringify(carrito));

                        cargarCarritoDeLocalStorage();
                        DOMcarrito.textContent = "";
                        renderizarCarrito();
                    } else {
                        let prodAux = null;
                        for (i = 0; i < carrito.length; i++) {
                            let aux = carrito[i].nombre;
                            aux = aux.replaceAll(' ', '');
                            if (aux === nombreImagen) {
                                //lo encuentra
                                prodAux = carrito[i];
                                carrito.splice(i, contadorProducto);
                            }
                        }
                        for (i = 0; i < contadorProducto - 1; i++) {
                            carrito.push(prodAux);
                        }

                        localStorage.setItem("carrito", JSON.stringify(carrito));

                        cargarCarritoDeLocalStorage();
                        DOMcarrito.textContent = "";
                        renderizarCarrito();

                    }

                }

                cargarCarritoDeLocalStorage();
                renderizarCarrito();

            });





        </script>



        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href="estilos/carrito.css"/>

        <title>Document</title>
    </head>
    <body>


        <div class = "container">


            <nav class="menu">
                <ul class="flex">
                    <li class="boton-nav" ><a href="http://localhost:8080/Bar">Inicio</a></li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/login">Acceso</a></li>
                    <li class="boton-nav"> Contacto</li>
                </ul>
            </nav>




            <div class="menu-productos"> 

                <div class="tipo-menu">
                    <h2>Carrito</h2>
                </div>



                <div class="elementos-menu" id="elementos-menu">




                </div>

            </div>


        </div>








    </body>
</html>
