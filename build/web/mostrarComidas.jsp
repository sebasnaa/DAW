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
                    <li class="boton-nav">Reservas</li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/login">Acceso</a></li>
                    <li class="boton-nav"> Contacto</li>
                </ul>
            </nav>

            <nav class="nav-tipos-menus">
                <ul class="flex">
                    <li class="boton-eleccion-menus" ><a href="../menu/bebidas">Refrescos</a></li>
                    <li class="boton-eleccion-menus">Comida</li>
                    <li class="boton-eleccion-menus">Cocteles</li>
                    <li class="boton-eleccion-menus">Cafes</li>
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
                            System.out.println("Comida " + imagen);
                    %>

                    <div class="item-menu">

                        <img src=<%= imagen%> alt=<%= c.getNombre()%> class="item-menu-image">
                        <div class="item-menu-descripcion">
                            <h3 class="menu-item-titulo">
                                <span class="menu-item-nombre"> <%= c.getNombre()%> </span>
                                <span class="menu-item-precio">$ <%= c.getPrecio()%></span>
                            </h3>
                            <div class="descripcion-boton">
                                <p> <%= c.getDescripcion()%> </p>
                                <div class="botones-productos">

                                    <%        if(usuarioLogeado){  %>                           
                                    <button class="botones-productos-editar" >Editar</button>
                                    <% } %>
                                    <button class="botones-productos-add" >añadir</button>
                                    

                                </div>


                            </div>
                        </div>               
                    </div>


                    <% }%>

                </div>

            </div>

        </div>

       

    </body>
</html>
