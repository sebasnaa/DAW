
<%@page import="beans.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>



        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href ="estilos/formularioAgregarProducto.css"


              </head>
    <body class="flex">
        <div class="container">

            <img src="images/fondo3.jpg" class="fondo" alt="">




            <nav class="menu">
                <ul class="flex">
                    <li class="boton-nav" ><a href="http://localhost:8080/Bar">Inicio</a></li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/login">Acceso</a></li>
                    <li class="boton-nav">Contacto</li>
                    <li class="boton-nav"><a href="http://localhost:8080/Bar/carritoDos.jsp">Carrito</a></li>


                    <%
                        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
                        if (usuarioSesion != null) {
                    %> <li class="boton-nav boton-cerrar-sesion "  id="cerraSesion" ><a href="loginOut">Cerrar Sesion</a></li> <%
                        }

                        String tipoProducto = "Bebida";

                        %>

                </ul>
            </nav>


            <div class="containerAgregar" >
                <h1 class="formulario_titulo" style="text-decoration: underline"> <%=tipoProducto%> </h1>
                <span id="mensajeNombreExistente" ></span>
                <form class="formulario-agregar-producto" id="formulario-producto" enctype="multipart/form-data" action="agregarProducto/bebida" method="post">


                    <div>
                        <label  for="nombreP" >Nombre </label>
                        <input type="text" id="nombreP" oninput="nombreValido()" name="nombreProductoAgregar">
                        <div class="formulario_mensaje-error-entrada"></div>
                    </div>
                    <div>
                        <label  for="precioP" > Precio </label>
                        <input type="text" id="precioP" name="precioProductoAgregar">
                        <div class="formulario_mensaje-error-entrada"></div>
                    </div>
                    <div>
                        <label  for="descripcionP" >Descripcion </label>
                        <input type="text" id="descripcionP" name="descripcionProductoAgregar">
                        <div class="formulario_mensaje-error-entrada"></div>
                    </div>
                    <div>
                        <label  for="imagenP" >Imagen</label>
                        <!--accept="image/*"-->
                        <input type="file" id="imagenP"  name="imagenProductoAgregar">
                    </div>
                    <input class="formulario_boton" type="submit" value="Agregar">



                </form>
            </div>

        </div>




    </body>
    <script src="js/jQuery.js"></script>
    <script src="js/controlCrearProducto.js"></script>



</html>