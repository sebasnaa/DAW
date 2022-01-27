<%-- 
    Document   : newjsp
    Created on : 02-ene-2022, 10:50:21
    Author     : sebas
--%>




<%@page import="beans.Usuario"%>
<%@page import="beans.Comida"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="beans.Bebida"%>
<%

    ArrayList<Comida> lista = (ArrayList<Comida>) request.getAttribute("comidas");
    Iterator<Comida> itComida = lista.iterator();

    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
    boolean usuarioLogeado = false;
    if (usuarioSesion != null) {
        System.out.println("usuario " + usuarioSesion.getNombre());

        if (usuarioSesion.getRol().equals("admin")) {
            usuarioLogeado = true;
        }
    }

    String tipoProducto = "comida";
    session.setAttribute("tipoProducto", tipoProducto);


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>




        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../estilos/estilos.css">
        <link rel="stylesheet" href="../estilos/productos.css">
        <link rel="stylesheet" href="../estilos/queryMenu.css"/>
        <title>Document</title>
    </head>
    <body>


        <div class = "container">


            <nav class="menu">
                <ul class="flex">
                    <li class="boton-nav" ><a href="http://localhost:8080/Bar">Inicio</a></li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/login">Acceso</a></li>
                    <li class="boton-nav"> Contacto</li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/carritoDos.jsp">Carrito</a></li>
                </ul>
            </nav>

            <nav class="nav-tipos-menus">
                <ul class="flex">
                    <li class="boton-eleccion-menus" ><a href="../menu/bebidas">Refrescos</a></li>
                    <li class="boton-eleccion-menus">Comida</li>
                    <li class="boton-eleccion-menus">Cocteles</li>
                        <%                            if (usuarioLogeado) {
                        %> <li class="boton-eleccion-menus" class="boton-eleccion-menus-add" ><a href="http://localhost:8080/Bar/agregarProducto.jsp">Añadir producto</a></li> <%
                            }
                        %>
                </ul>
            </nav>



            <div class="menu-productos"> 

                <div class="tipo-menu">
                    <h2>Comidas</h2>
                </div>



                <div class="elementos-menu">

                    <%                        while (itComida.hasNext()) {
                            Comida c = itComida.next();
                            String imagen = "../images/productos/comidas/" + c.getNombre() + ".png";
                            imagen = imagen.replaceAll(" ", "");
                            String nombre = c.getNombre();
                            double p = c.getPrecio();
                            String desc = c.getDescripcion();
                            String nombreObjetoClear = c.getNombre().replaceAll(" ", "");
                    %>

                    <div class="item-menu">

                        <img id="imagen<%=nombreObjetoClear%>" src=<%= imagen%> alt=<%= c.getNombre()%> class="item-menu-image">
                        <div class="item-menu-descripcion">
                            <h3 class="menu-item-titulo">
                                <span class="menu-item-nombre" id="nombre<%=nombreObjetoClear%>"> <%= c.getNombre()%> </span>
                                <span class="menu-item-precio" id="precio<%=nombreObjetoClear%>" ><%= c.getPrecio() + " € "%></span>
                            </h3>
                            <div class="descripcion-boton">
                                <p id="descripcion<%=nombreObjetoClear%>" > <%= c.getDescripcion()%> </p>
                                <div class="botones-productos">

                                    <%        if (usuarioLogeado) {%>                           
                                    <button class="botones-productos-editar" onclick="mostrarForm(' <%= c.getNombre()%>', ' <%= c.getPrecio()%>', ' <%= c.getDescripcion()%>');" >Editar</button>
                                    <% }%>
                                    <button class="botones-productos-add" onclick="addCarro('<%=nombre%>', '<%=p%>');" >añadir</button>


                                </div>


                            </div>
                        </div>   

                        <form class="formulario_editar_oculto" id="formulario_editar_<%=nombreObjetoClear%>" method="post" >
                            <input class="nombreProductoEditar_<%=nombreObjetoClear%>"" type="text" name="nombreProductoF" autofocus  value="<%= c.getNombre()%>" >
                            <input class="precioProductoEditar_<%=nombreObjetoClear%>"" type="text" name="precioF"   value="<%= c.getPrecio()%>" >
                            <input class="descProductoEditar_<%=nombreObjetoClear%>"" type="text" name="descripcionProductoF"  value="<%= c.getDescripcion()%>" >
                            <div class="botones-edicion" >
                                <span class="boton-envia-editar" id="botones-edicion-enviarDos" onclick="actualizarComida(' <%= c.getNombre()%>', '<%=nombreObjetoClear%>')"  > Guardar </span>
                                <span class="boton-cancela-editar" id="botones-edicion-cancelar" onclick="mostrarForm(' <%= c.getNombre()%>', ' <%= c.getPrecio()%>', ' <%= c.getDescripcion()%>');"  > X </span>
                            </div>
                        </form>

                    </div>


                    <% }%>

                </div>

            </div>

        </div>

        <script type="text/javascript" src="../js/jQuery.js" async></script>

        <script>
                                    function addCarro(nombre, precio) {

                                        var carrito = JSON.parse(localStorage.getItem("carrito"));

                                        if (carrito == null)
                                            carrito = [];
                                        var nombre = nombre;
                                        var precio = precio;
                                        var entry = {
                                            "nombre": nombre,
                                            "precio": precio,
                                            "imagen": nombre
                                        };
                                        localStorage.setItem("entry", JSON.stringify(entry));
                                        carrito.push(entry);
                                        localStorage.setItem("carrito", JSON.stringify(carrito));
                                    }
                                    function mostrarForm(nombre) {

                                        nombre = nombre.replaceAll(' ', '');
                                        let id = 'formulario_editar_' + nombre;
                                        const formulario = document.getElementById(id);

                                        if (formulario.className == "formulario_editar_oculto") {
                                            formulario.classList.remove("formulario_editar_oculto");
                                            formulario.classList.add("formulario_editar");


                                        } else {
                                            formulario.classList.remove("formulario_editar");
                                            formulario.classList.add("formulario_editar_oculto");
                                        }


                                    }

        </script>

        <script>

            function actualizarComida(nombreOriginal, nombreBusqueda) {

                var nombreMod = document.querySelector('.nombreProductoEditar_' + nombreBusqueda).value;
                var precioMod = document.querySelector('.precioProductoEditar_' + nombreBusqueda).value;
                var desMod = document.querySelector('.descProductoEditar_' + nombreBusqueda).value;

                $.ajax({
                    url: '/Bar/editarProducto/comida',
                    type: 'POST',
                    data: {nombreOriginal: nombreOriginal, nombreMod: nombreMod, precioMod: precioMod, desMod: desMod},
                    success: function (resultText) {

                        if (resultText === "mod") {
                            location.reload();
//                            mostrarForm(nombreBusqueda);
//                            document.getElementById("nombre" + nombreBusqueda).innerText = nombreMod;
//                            document.getElementById("precio" + nombreBusqueda).innerText = precioMod + ' € ';
//                            document.getElementById("descripcion" + nombreBusqueda).innerText = desMod;
//                            var nombreFoto = nombreMod.replaceAll(' ', '');
//                            document.getElementById("imagen" + nombreBusqueda).src = "../images/productos/bebidas/" + nombreFoto + ".jpg";

                        }
                    },
                    error: function (jqXHR, exception) {
                        console.log('Error!!');

                    }
                });
            }



        </script>

    </body>
</html>
