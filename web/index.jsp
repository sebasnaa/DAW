<%-- 
    Document   : inicio
    Created on : 13-ene-2022, 1:38:23
    Author     : sebas
--%>

<%@page import="beans.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>



        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="estilos/estilos.css">



        <title>Document</title>
    </head>
    <body class="flex">
        <div class="container">

            <img src="images/fondo3.jpg" class="fondo" alt="">
            <a class="boton" href="menu/bebidas">MENU</a>




            <nav class="menu">
                <ul class="flex">
                    <li class="boton-nav">Inicio</li>
                    <li class="boton-nav"><a href="login">Acceso</a></li>
                    <li class="boton-nav">Contacto</li>
                    <li class="boton-nav"><a href="carritoDos.jsp">Carrito</a></li>

                    <%
                        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
                        if (usuarioSesion != null) {
                    %> <li class="boton-nav boton-cerrar-sesion "  id="cerraSesion" ><a href="loginOut">Cerrar Sesion</a></li> <%
                               }

                        %>




                </ul>
            </nav>



            <div class="informacion-web">
                <h1>Bienvenido a </h1>
                <h2>Surgut Bar</h2>
                <div class="parrafo">
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestiae sapiente corrupti<br> excepturi praesentium, iste temporibus ea totam at natus porro dolor sequi eveniet debitis nobis a eaque quas ex? Laboriosam.</p>
                </div>
                <div class="redes-sociales">
                    <li class="icon-facebook flex"></li>
                    <li class="icon-youtube flex"></li>
                    <li class="icon-instagram flex"></li>
                </div>
            </div>





        </div>

        


    </body>




</html>