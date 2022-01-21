<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title></title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">-->
        <script>
            document.addEventListener('DOMContentLoaded', () => {

                // Variables
                let carrito = [
                    {
                        id: 1,
                        nombre: 'Agua',
                        precio: 1,
                        imagen: 'Agua.jpg'
                    },
                    {
                        id: 2,
                        nombre: 'Cebolla',
                        precio: 1.2,
                        imagen: 'cebolla.jpg'
                    }, {
                        id: 2,
                        nombre: 'Cebolla',
                        precio: 1.2,
                        imagen: 'cebolla.jpg'
                    }
                    , {
                        id: 2,
                        nombre: 'tomate',
                        precio: 1.2,
                        imagen: 'cebolla.jpg'
                    }
                    , {
                        id: 2,
                        nombre: 'cocacola',
                        precio: 1.2,
                        imagen: 'cebolla.jpg'
                    }
                    , {
                        id: 2,
                        nombre: 'fanta',
                        precio: 1.2,
                        imagen: 'cebolla.jpg'
                    }

                ];
                //     let carrito = JSON.parse(localStorage.getItem("carrito"));

                const divisa = '$';
                const DOMitems = document.querySelector('#items');
                const DOMcarrito = document.querySelector('#carrito');
                const DOMtotal = document.querySelector('#total');
                const DOMbotonVaciar = document.querySelector('#boton-vaciar');
                const miLocalStorage = window.localStorage;
                // Funciones

                /**
                 * Dibuja todos los productos a partir de la base de datos. No confundir con el carrito
                 */




                /**
                 * Dibuja todos los productos guardados en el carrito
                 */
                function renderizarCarrito() {
                    // Vaciamos todo el html
                    DOMcarrito.textContent = '';
                    // Generamos los Nodos a partir de carrito
                    const nombreP = carrito.map(n => n.nombre);
                    const carritoFiltrado = carrito.filter(({nombre}, indice) => !nombreP.includes(nombre, indice + 1));
                    const nodoCarrito = document.getElementById('carrito');
                    carritoFiltrado.forEach((item) => {

//                     

                        let cont = 0;
                        for (i = 0; i < carrito.length; i++) {
                            if (carrito[i].nombre == item.nombre) {
                                cont = cont + 1;
                            }
                        }
                        // Creamos el nodo del item del carrito
                        const miNodo = document.createElement('li');
                        miNodo.classList.add('item-menu');

                        const miNodoImg = document.createElement("img");
                        miNodoImg.classList.add('item-menu-image');
                        miNodoImg.src = "images/productos/bebidas/" + item.nombre + ".jpg";
                        miNodoImg.alt = "404";
                        const miNodoTexto = document.createElement("p");
                        salida = cont + ' ' + item.nombre + ' x ' + item.precio + '$';
                        miNodoTexto.textContent = salida;

                        // Boton de borrar
                        const miBoton = document.createElement('button');
                        miBoton.classList.add('btn');
                        miBoton.textContent = 'Quitar';
                        miBoton.style.marginLeft = '1rem';
                        miBoton.dataset.item = item;
                        miBoton.addEventListener('click', borrarItemCarrito);
                        // Mezclamos nodos
                        miNodo.appendChild(miNodoImg);
                        miNodo.appendChild(miNodoTexto)
                        miNodo.appendChild(miBoton);

                        DOMcarrito.appendChild(miNodo);
                    });
                    // Renderizamos el precio total en el HTML
                    DOMtotal.textContent = calcularTotal();
                }

                /**
                 * Evento para borrar un elemento del carrito
                 */
                function borrarItemCarrito(evento) {
                    // Obtenemos el producto ID que hay en el boton pulsado
                    const nombre = evento.target.dataset.nombre;
                    // Borramos todos los productos
                    console.log(nombre)
                    carrito = carrito.filter((nombre) => {
                        return nombre !== nombre;
                    });
                    // volvemos a renderizar
                    renderizarCarrito();
                    // Actualizamos el LocalStorage
//                    guardarCarritoEnLocalStorage();
                }

                /**
                 * Calcula el precio total teniendo en cuenta los productos repetidos
                 */
                function calcularTotal() {

                    let total = 0;
                    for (i = 0; i < carrito.length; i++) {
                        total += carrito[i].precio;
                    }

                    return total;
                }

                /**
                 * Varia el carrito y vuelve a dibujarlo
                 */
                function vaciarCarrito() {
                    // Limpiamos los productos guardados
                    carrito = [];
                    // Renderizamos los cambios
                    renderizarCarrito();
                    // Borra LocalStorage
                    localStorage.clear();
                }



//                                function cargarCarritoDeLocalStorage() {
//                                    // ¿Existe un carrito previo guardado en LocalStorage?
//                                    if (miLocalStorage.getItem('carrito') !== null) {
//                                        // Carga la información
//                                        carrito = JSON.parse(miLocalStorage.getItem('carrito'));
//                                    }
//                                }

                // Eventos
                DOMbotonVaciar.addEventListener('click', vaciarCarrito);
                // Inicio
//                                cargarCarritoDeLocalStorage();
                renderizarCarrito();
            });
        </script>
        <link rel="stylesheet" href="estilos/carrito.css"/>
    </head>
    <body>
        <div class="container">
            <!-- Elementos generados a partir del JSON -->
            <!-- Carrito -->
            <h2>Carrito</h2>
            <!-- Elementos del carrito -->
            
            
            <div class="elementos-menu" id="elementos-menu">
                
                
                <div class="item-menu">

                    <img src="images/productos/bebidas/Agua.jpg" alt="Agua" class="item-menu-image">
                        <div class="item-menu-descripcion">
                            <h3 class="menu-item-titulo">
                                <span class="menu-item-nombre"> Agua</span>
                                <span class="menu-item-precio">  10 </span>
                            </h3>
                            <div class="descripcion-boton">
                                <p>Descripcion de agua </p>
                                <div class="botones-productos">

                                    
                                    <button >X</button>
                                </div>


                            </div>
                        </div>
                
                
            </div>
            
            <hr>
            <!-- Precio total -->
            <p class="text-right">Total: <span id="total"></span>&euro;</p>
            <button id="boton-vaciar" class="btn btn-danger">Vaciar</button>
        </div>
    </body>
</html>