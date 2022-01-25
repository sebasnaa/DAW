/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Bebida;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;
import sun.net.smtp.SmtpClient;

import java.io.*;
import java.net.URI;
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
        System.out.println("" + ruta);
        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();
        int filasAfectadas = 0;
        PreparedStatement ps;

        String nombre = request.getParameter("nombreProductoAgregar");
        String precio_str = request.getParameter("precioProductoAgregar");
        double precio = Double.parseDouble(precio_str);
        String descripcion = request.getParameter("descripcionProductoAgregar");

        Part imagen = request.getPart("imagenProductoAgregar");
        String nombreImagen = nombre.replaceAll(" ", "");

        switch (accion) {

            case "/Bar/agregarProducto/bebida":

                System.out.println("entra en agregar");

                
                System.out.println(nombre);
                System.out.println(precio);
                System.out.println(descripcion);
                System.out.println(imagen);

                InputStream fileContent = imagen.getInputStream();
                InputStream fileDos = imagen.getInputStream();
                File targetFile = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\bebidas\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileContent, targetFile);

                File targetFileDos = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileDos, targetFileDos);

//                ps = conn.prepareStatement("INSERT INTO BEBIDAS (NOMBRE, PRECIO, DESCRIPCION) VALUES (?, ?,?)");
//                ps.setString(1,nombre);
//                ps.setDouble(2, precio);
//                ps.setString(3, descripcion);
//
//                filasAfectadas = ps.executeUpdate();
//                String msg;
//                if (filasAfectadas > 0) {
//                    msg = "<p> OK insercion correcta </p>";
//                } else {
//                    msg = "<p> Se ha liado </p>";
//                }
//                ps.close();
                conn.close();
                break;

            case "/Bar/agregarProducto/comida":

                System.out.println("entra en agregar");

                InputStream fileContentComida = imagen.getInputStream();
                File targetFileComida = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\comidas\\" + nombreImagen + ".png");
                copyInputStreamToFile(fileContentComida, targetFileComida);
                
                InputStream fileContentComidaDos = imagen.getInputStream();
                File targetFileComidaDos = new File("C:\\Users\\sebas\\Desktop\\portatil_archivos\\archivos_pc_viejo\\Ingenieria Informatica Huelva UHU ETSI\\Curso 2021-2022\\1º Cuatrimestre\\DAW\\PracticaBD\\Bar\\web\\images\\productos\\" + nombreImagen + ".jpg");
                copyInputStreamToFile(fileContentComidaDos, targetFileComidaDos);

//                ps = conn.prepareStatement("INSERT INTO COMIDA (NOMBRE, PRECIO, DESCRIPCION) VALUES (?, ?,?)");
//                ps.setString(1,nombre);
//                ps.setDouble(2, precio);
//                ps.setString(3, descripcion);
//
//                filasAfectadas = ps.executeUpdate();
//                String msg;
//                if (filasAfectadas > 0) {
//                    msg = "<p> OK insercion correcta </p>";
//                } else {
//                    msg = "<p> Se ha liado </p>";
//                }
//                ps.close();
                conn.close();
                break;
        }

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
