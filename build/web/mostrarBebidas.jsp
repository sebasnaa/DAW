<%-- 
    Document   : newjsp
    Created on : 02-ene-2022, 10:50:21
    Author     : sebas
--%>




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
<%
    
    ArrayList<Bebida> lista = (ArrayList<Bebida>) request.getAttribute("bebidas");
    Iterator<Bebida> itBebida = lista.iterator();
    Gson g = new Gson();
//    String salida = g.toJson(lista);
//    System.out.println(salida);
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
    boolean usuarioLogeado = false;
    if (usuarioSesion != null) {
//        System.out.println(usuarioSesion);
        if (usuarioSesion.getRol().equals("admin")) {
            usuarioLogeado = true;
        }
    }
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
                    <li class="boton-eleccion-menus" >Refrescos</li>
                    <!--                    <li class="boton-eleccion-menus">Comida</li>-->
                    <li class="boton-eleccion-menus"><a href="../menu/comidas">Comida</a></li>
                    <li class="boton-eleccion-menus">Cocteles</li>
                    <li class="boton-eleccion-menus">Cafes</li>
                        <%                            
                            if (usuarioSesion != null) {
                        %> <li class="boton-eleccion-menus" class="boton-eleccion-menus-add" >Añadir producto</li> <%        
                            }

                        %>


                </ul>
            </nav>



            <div class="menu-productos"> 

                <div class="tipo-menu">
                    <h2>Refrescos</h2>
                </div>



                <div class="elementos-menu" id="elementos-menu">

                    <%                        while (itBebida.hasNext()) {
                            Bebida b = itBebida.next();
                            String imagen = "../images/productos/bebidas/" + b.getNombre() + ".jpg";
                            imagen = imagen.replaceAll(" ", "");
                            
                            String nombreObjetoClear = b.getNombre().replaceAll(" ", "");
                            
                            System.out.println(nombreObjetoClear);
                            
                            String nombre = b.getNombre();
                            double p = b.getPrecio();
                            String desc = b.getDescripcion();
                    %>

                    <div class="item-menu">

                        <img id="imagen<%=nombreObjetoClear%>" src=<%= imagen%> alt=<%= b.getNombre()%> class="item-menu-image">
                        <div class="item-menu-descripcion">
                            <h3 class="menu-item-titulo">
                                <span class="menu-item-nombre" id="nombre<%=nombreObjetoClear%>" > <%= b.getNombre()%> </span>
                                <span class="menu-item-precio " id="precio<%=nombreObjetoClear%>" > <%= b.getPrecio() + " € "%></span>
                            </h3>
                            <div class="descripcion-boton">
                                <p id="descripcion<%=nombreObjetoClear%>" > <%= b.getDescripcion()%> </p>
                                <div class="botones-productos">

                                    <% if (usuarioLogeado) {%>
                                    <% }%>
                                    <button class="botones-productos-editar" onclick="mostrarForm(' <%= b.getNombre()%>', ' <%= b.getPrecio()%>', ' <%= b.getDescripcion()%>');" >Editar</button>
                                    <button class="botones-productos-add" id="botonAdd" onclick="pp('<%= nombre%>', '<%= p%>');" >Añadir</button>
                                </div>


                            </div>
                        </div>  


                        <form class="formulario_editar_oculto" id="formulario_editar_<%=nombreObjetoClear%>" method="post" >
                            <input class="nombreProductoEditar_<%=nombreObjetoClear%>"" type="text" name="nombreProductoF" autofocus  value="<%= b.getNombre()%>" >
                            <input class="precioProductoEditar_<%=nombreObjetoClear%>"" type="text" name="precioF"   value="<%= b.getPrecio()%>" >
                            <input class="descProductoEditar_<%=nombreObjetoClear%>"" type="text" name="descripcionProductoF"  value="<%= b.getDescripcion()%>" >
                            <div class="botones-edicion" >
                                <!--<span class="boton-cancela-editar" id="botones-edicion-cancelar" onclick="mostrarForm(' <%= b.getNombre()%>', ' <%= b.getPrecio()%>', ' <%= b.getDescripcion()%>');"  >  </span>-->
                                <span class="boton-envia-editar" id="botones-edicion-enviarDos" onclick="actualizarBebida(' <%= b.getNombre()%>', '<%=nombreObjetoClear%>')"  > Guardar </span>
                                <span class="boton-cancela-editar" id="botones-edicion-cancelar" onclick="mostrarForm(' <%= b.getNombre()%>', ' <%= b.getPrecio()%>', ' <%= b.getDescripcion()%>');"  > X </span>
                            </div>
                        </form>


                    </div>





                    <% }%>

                </div>

            </div>


        </div>

        <script type="text/javascript" src="../js/jQuery.js" async></script>

        <!--<script src="https://code.jquery.com/jquery-3.3.1.js"></script>-->

        <script>
                                    
                                    //                function $(selector) {
                                    //                    return document.querySelector(selector);
                                    //                }
                                    
                                    function pp(nombre, precio) {
                                        
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
                                    
                                    function mostrar(nombreProducto) {
                                        console.log(nombreProducto);
                                        
                                        
                                        
                                        
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
            
            function actualizarBebida(nombreOriginal, nombreBusqueda) {
                
                var nombreMod = document.querySelector('.nombreProductoEditar_' + nombreBusqueda).value;
                var precioMod = document.querySelector('.precioProductoEditar_' + nombreBusqueda).value;
                var desMod = document.querySelector('.descProductoEditar_' + nombreBusqueda).value;
//                var nombreO = document.querySelector("nombre" + nombreBusqueda).value;
         
                
                $.ajax({
                    url: '/Bar/agregarProducto/bebida',
                    type: 'POST',
                    data: {nombreOriginal: nombreOriginal, nombreMod: nombreMod, precioMod: precioMod, desMod: desMod},
                    success: function (resultText) {
                        
                        if (resultText === "mod") {
//                            mostrarForm(nombreBusqueda);
                            
                            
                            document.getElementById("nombre" + nombreBusqueda).innerText = nombreMod;
                            document.getElementById("precio" + nombreBusqueda).innerText = precioMod + ' € ';
                            document.getElementById("descripcion" + nombreBusqueda).innerText = desMod;
                            var nombreFoto = nombreMod.replaceAll(' ', '');
                            document.getElementById("imagen" + nombreBusqueda).src = "../images/productos/bebidas/" + nombreFoto + ".jpg";
                            
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
