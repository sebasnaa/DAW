/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Usuario;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import java.io.*;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;
import static org.apache.jasper.Constants.DEFAULT_BUFFER_SIZE;

/**
 *
 * @author sebas
 */
@MultipartConfig
@WebServlet(name = "agregarProducto", urlPatterns = {"/agregarProducto/*"})
public class agregarProducto extends HttpServlet {

    @Resource(name = "recurso")
    private DataSource recurso;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getRequestURI();

        String ruta = request.getPathTranslated();
        System.out.println("" + accion);
        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();
        int filasAfectadas = 0;
        PreparedStatement ps;

        double precio = 0;
        String nombre;
        String precio_str;
        String descripcion;
        String nombreImagen;

        request.getSession();

        Part imagen;
        switch (accion) {

            case "/Bar/agregarProducto/bebida":

                System.out.println("entra en agregar");

                nombre = request.getParameter("nombreProductoAgregar");
                precio_str = request.getParameter("precioProductoAgregar");
                descripcion = request.getParameter("descripcionProductoAgregar");
                nombreImagen = nombre.replaceAll(" ", "");
                precio = Double.parseDouble(precio_str);
                imagen = request.getPart("imagenProductoAgregar");

                InputStream fileContent = imagen.getInputStream();
                InputStream fileDos = imagen.getInputStream();
                File targetFile = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\bebidas\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileContent, targetFile);

                File targetFileDos = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileDos, targetFileDos);

                ps = conn.prepareStatement("INSERT INTO BEBIDAS (NOMBRE, PRECIO, DESCRIPCION) VALUES (?, ?,?)");
                ps.setString(1, nombre);
                ps.setDouble(2, precio);
                ps.setString(3, descripcion);

                filasAfectadas = ps.executeUpdate();
                String msg;
                if (filasAfectadas > 0) {
                    msg = "<p> OK insercion correcta </p>";
                } else {
                    msg = "<p> Se ha liado </p>";
                }

                Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuarioSesion");
                System.out.println(usuarioSesion);
                request.getRequestDispatcher("../menu/bebidas").forward(request, response);
//                request.getRequestDispatcher("../agregarProducto").forward(request, response);

                break;

            case "/Bar/agregarProducto/comida":

                System.out.println("entra en agregar");

                nombre = request.getParameter("nombreProductoAgregar");
                precio_str = request.getParameter("precioProductoAgregar");
                descripcion = request.getParameter("descripcionProductoAgregar");
                nombreImagen = nombre.replaceAll(" ", "");
                precio = Double.parseDouble(precio_str);

                imagen = request.getPart("imagenProductoAgregar");

                InputStream fileContentComida = imagen.getInputStream();
                File targetFileComida = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\comidas\\" + nombreImagen + ".png");
                copyInputStreamToFile(fileContentComida, targetFileComida);

                InputStream fileContentComidaDos = imagen.getInputStream();
                File targetFileComidaDos = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileContentComidaDos, targetFileComidaDos);

                ps = conn.prepareStatement("INSERT INTO COMIDAS (NOMBRE, PRECIO, DESCRIPCION) VALUES (?, ?,?)");
                ps.setString(1, nombre);
                ps.setDouble(2, precio);
                ps.setString(3, descripcion);

                filasAfectadas = ps.executeUpdate();
                if (filasAfectadas > 0) {
                    msg = "<p> OK insercion correcta </p>";
                    System.out.println("Insercion bien");
                } else {
                    System.out.println("Insercion mla");

                    msg = "<p> Se ha liado </p>";
                }

                request.getRequestDispatcher("../menu/comidas").forward(request, response);
//                request.getRequestDispatcher("../agregarProducto").forward(request, response);

                break;

            case "/Bar/agregarProducto/comprobarbebida":

                String entrada = request.getParameter("nombre");
                response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8"); // You want world domination, huh?

                PreparedStatement pr = null;
                ResultSet rs = null;
                boolean state = false;
                try {
                    pr = conn.prepareStatement("SELECT * FROM BEBIDAS WHERE NOMBRE = ?");
                    pr.setString(1, entrada);
                    rs = pr.executeQuery();
                    state = rs.next();

                    if (state) {
                        response.getWriter().write("Ya existe producto");
                    }
                    if (!state) {
                        response.getWriter().write("");
                    }

                } catch (SQLException ex) {

                    System.out.println("Fallo en comprobacion");
                }

                break;

            case "/Bar/agregarProducto/comprobarcomida":

                System.out.println("entra");
                entrada = request.getParameter("nombre");
                response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8"); // You want world domination, huh?

                pr = null;
                rs = null;
                state = false;
                try {
                    pr = conn.prepareStatement("SELECT * FROM COMIDAS WHERE NOMBRE = ?");
                    pr.setString(1, entrada);
                    rs = pr.executeQuery();
                    state = rs.next();

                    if (state) {
                        response.getWriter().write("Ya existe producto");
                    }
                    if (!state) {
                        response.getWriter().write("");
                    }

                } catch (SQLException ex) {

                    System.out.println("Fallo en comprobacion");
                }

                break;

        }
        System.out.println("llega al final");
        conn.close();

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(agregarProducto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(agregarProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(agregarProducto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(agregarProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private static void copyInputStreamToFile(InputStream inputStream, File file)
            throws IOException {

        // append = false
        try (FileOutputStream outputStream = new FileOutputStream(file, false)) {
            int read;
            byte[] bytes = new byte[DEFAULT_BUFFER_SIZE];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }

    }
}
