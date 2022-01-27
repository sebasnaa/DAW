<%-- 
    Document   : login
    Created on : 14-ene-2022, 1:22:26
    Author     : sebas
--%>

<%@page import="beans.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String estadologinUsuario = (String) request.getAttribute("flag");

    String estado = "logged";

    HttpSession sesionACtual = request.getSession();


%>





<!DOCTYPE html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Acceso Cuenta / Crear Cuenta</title>
    <link rel="shortcut icon" href="/assets/favicon.ico">
    <!--<link rel="stylesheet" href="estilos/estilos.css">-->
    <link rel="stylesheet" href="estilos/loginCrearCuenta.css">
</head>

<body>



    <div  id="estadoLog" ></div>

    <div class = "container">

        <nav class="menu">
            <ul class="flex">
                <li class="boton-nav" ><a href="http://localhost:8080/Bar">Inicio</a></li>
                <li class="boton-nav">Acceso</li>
                <li class="boton-nav"> Contacto</li>

                <%                    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
//                    System.out.println("Usuario no log");
                    String cerrarBoton = "";
                    if (usuarioSesion != null) {
                %> <li class="boton-nav boton-cerrar-sesion "  id="cerraSesion" ><a href="loginOut">Cerrar Sesion</a></li> <%
                    }

                    %>


            </ul>
        </nav>
    </div>


    <div class="containerLogin">


        <div id ="estadoUsuario" > </div>

        <form class="formulario" id="Acceso"  method="post" action="login/Acceder"> 
            <h1 class="formulario_titulo">Acceso</h1>
            <div class="formulario_mensaje formulario_mensaje-error"></div>

            <div class="formulario_datos_entrada_grupo">
                <input type="text" name="nombreUsuarioLogin"  id="nombreUsuarioLogin" class="formulario_entrada" autofocus placeholder="Correo">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <div class="formulario_datos_entrada_grupo">
                <input type="password" name="passwordUsuarioLogin"  id="passwordLogin" class="formulario_entrada" autofocus placeholder="Contraseña">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <button class="formulario_boton" id="botonLog" type="submit" >Acceder</button>

            <p class="formulario_texto">
                <a href="#" class="formulario_link">¿Has olvidado la contraseña?</a>

            </p>
            <p class="formulario_texto">
                <a class="formulario_link" id="enlaceCrearCuenta">Crear Cuenta</a>
            </p>
        </form>






        <form class="formulario formulario_oculto" id="CrearCuenta" method="post" action="login/crearCuenta">
            <h1 class="formulario_titulo">Crear Cuenta</h1>
            <div class="formulario_mensaje formulario_mensaje-error"></div>

            <div class="formulario_datos_entrada_grupo">
                <input type="text"  onchange="eliminarMensajesErrores()" id="nombreUsuario" class="formulario_entrada" name="nombreUsuario" autofocus placeholder="Usuario">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <div class="formulario_datos_entrada_grupo">
                <input type="text" id="direccionUsuario" oninput="correoValido()" onchange="eliminarMensajesErrores()" class="formulario_entrada" name="correoUsuario" autofocus
                       placeholder="Direccón de correo">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <div class="formulario_datos_entrada_grupo">
                <input type="password" id="passwordPrimera" class="formulario_entrada"  autofocus placeholder="Contraseña">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <div class="formulario_datos_entrada_grupo">
                <input type="password" " id="passwordSegunda" class="formulario_entrada" name="passwordUsuario" autofocus placeholder="Repetir Contraseña">
                <div class="formulario_mensaje-error-entrada"></div>
            </div>

            <p id ="mensajeCorreoExistente" ></p>


            <!--<button class="formulario_boton" id="botonCrer" type="submit">Crear</button>-->
            <button class="formulario_boton" id="botonCrear" type="submit">Crear</button>


            <p class="formulario_texto">
                <a class="formulario_link" id="EnlaceAcceso"  >Acceder a Cuenta</a>
            </p>

        </form>
    </div>

    <script src="js/jQuery.js"></script>
    <script src="js/logginCreacionCuenta.js"></script>







    <!--<script src="js/controlAjaxLogin.js"></script>-->
</body>

