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
        System.out.println(usuarioSesion);
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

                            String StringJsonBebida = g.toJson(b);

//                            System.out.println(StringJsonBebida);
                            JSONObject jsonObj = new JSONObject();
                            jsonObj.put("id", b.getId());
                            jsonObj.put("nombre", b.getNombre());
                            jsonObj.put("precio", b.getPrecio());
                            jsonObj.put("descripcion", b.getDescripcion());
                            System.out.println("valor n " + jsonObj.toJSONString());

                            String nombre = b.getNombre();
                            double p = b.getPrecio();
                            String desc = b.getDescripcion();
//                        Bebida bebidaS = g.fromJson(StringJsonBebida, Bebida.class);
//                            System.out.println(" bebida mod "+ bebidaS.getNombre());
//                  {'id':0,"precio":2.0,'descripcion':"Bebida refrescante carbonatada sabor naranja",'nombre':"Kas Naranja"}
//{'id': 0, 'precio': 2.0, 'descripcion': 'Bebida refrescante carbonatada sabor naranja', 'nombre': 'Kas Naranja'}
//{ 'one': 1, 'two': 2, 'three': 3 }
                    %>

                    <div class="item-menu">

                        <img src=<%= imagen%> alt=<%= b.getNombre()%> class="item-menu-image">
                        <div class="item-menu-descripcion">
                            <h3 class="menu-item-titulo">
                                <span class="menu-item-nombre"> <%= b.getNombre()%> </span>
                                <span class="menu-item-precio">$ <%= b.getPrecio()%></span>
                            </h3>
                            <div class="descripcion-boton">
                                <p> <%= b.getDescripcion()%> </p>
                                <div class="botones-productos">

                                    <% if (usuarioLogeado) {  %>                           
                                    <button class="botones-productos-editar" >Editar</button>
                                    <% }%>
                                    <button class="botones-productos-add" id="botonAdd" onclick="pp('<%=nombre%>', '<%=p%>', '<%=desc%>');" >Añadir</button>
                                </div>


                            </div>
                        </div>               
                    </div>

                    <% }%>

                </div>

            </div>
                    
                     <button class="botones-productos-add" id="mostrar" onclick="mostrar();" >Show carrito</button>

        </div>



        <script>

            function $(selector) {
                return document.querySelector(selector);
            }

            function pp(nombre, precio, des) {

//                console.log(nombre);
//                console.log(precio);
//                console.log(des);
//                items = {'nombre': nombre, 'precio': precio, 'descripcion': des};



                var carrito = JSON.parse(localStorage.getItem("carrito"));

                if (carrito == null)
                    carrito = [];
                var nombre = nombre;
                var precio = precio;
                var entry = {
                    "nombre": nombre,
                    "precio": precio
                };
                localStorage.setItem("entry", JSON.stringify(entry));
                carrito.push(entry);
                localStorage.setItem("carrito", JSON.stringify(carrito));
            }

            function mostrar(){
                 let carrito = JSON.parse(localStorage.getItem("carrito"));
                console.log(carrito[0].title);
            }





        </script>






    </body>
</html>
