<%-- 
    Document   : prueba
    Created on : 14-ene-2022, 11:08:05
    Author     : sebas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    String nombre = (String)  request.getAttribute("nombre");
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <h2><%= nombre%></h2>
        
        Hola <%= request.getAttribute("nombre") %>
    </body>
</html>
