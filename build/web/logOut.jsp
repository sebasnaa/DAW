
<%@page import="beans.Usuario"%>
<%@ page language="java" 
         contentType="text/html; charset=windows-1256"
         pageEncoding="windows-1256"

         %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
        <meta http-equiv="Refresh" content="2;url=http://localhost:8080/Bar">
        <title>   User logout Successfully   </title>
    </head>

    <body>
        <center>




            <%

                String nombre = (String) (request.getAttribute("nombre"));

            %>
            Hasta pronto <%= nombre %>


        </center>
    </body>

</html>

