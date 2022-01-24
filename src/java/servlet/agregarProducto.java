/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import sun.net.smtp.SmtpClient;

/**
 *
 * @author sebas
 */
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

        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();

        String nombreOriginal = request.getParameter("nombreOriginal").trim();
//        nombreOriginal = nombreOriginal.trim();
        String nombreMod = request.getParameter("nombreMod");

        String precio_str = request.getParameter("precioMod");
//        precio_str = precio_str.replace('.', ',');
        double precio = Double.parseDouble(precio_str);
        String descripcion = request.getParameter("desMod");

//        PreparedStatement stmt;
//        System.out.println(nombreOriginal + " " + nombreMod + " " + precio + " " + descripcion);
//        System.out.println("ppp" + nombreOriginal + "ppp");
//        System.out.println("destino " + accion);

//        response.setContentType("text/plain");  
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write("entra");

        System.out.println("Nombre original: " +nombreOriginal  + "  nombreMod: " + nombreMod);

        if (nombreMod != null && nombreOriginal != null) {

            switch (accion) {

                case "/Bar/agregarProducto/bebida":

                    String sql = "UPDATE BEBIDAS SET  NOMBRE = ?, PRECIO = ?, DESCRIPCION = ? WHERE NOMBRE = ?";
                    String sql2 = "UPDATE ROOT.BEBIDAS SET  NOMBRE = ? WHERE NOMBRE = ?";

                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, nombreMod);
                    ps.setDouble(2, precio);
                    ps.setString(3, descripcion);
                ps.setString(4, nombreOriginal);
                
                    System.out.println(nombreOriginal);
                    int contador = ps.executeUpdate();
                    if (contador > 0) {
                        response.setContentType("text/plain");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write("mod");
                    }
                    System.out.println("NUmero de reg afectados " + contador);
                    ps.close();
                    conn.close();
//                    System.out.println("DAtos ");
//                    System.out.println(nombreOriginal);
//                    System.out.println(nombreMod);
//                    System.out.println(precio_str);
//                    System.out.println(precio);
//                    System.out.println(descripcion);
//                stmt = conn.prepareStatement("UPDATE BEBIDAS SET  NOMBRE = prueba ,PRECIO = 1000 ,DESCRIPCION = no funciona  WHERE NOMBRE = ?");
//                    stmt = conn.prepareStatement("UPDATE BEBIDAS SET  NOMBRE = ?, PRECIO = ?, DESCRIPCION = ? WHERE NOMBRE = ?");
//
//                    stmt.setString(1, nombreMod);
//                    stmt.setString(2, precio_str);
//                    stmt.setString(3, descripcion);
//                    stmt.setString(4, nombreOriginal);
//
//                    int contador = stmt.executeUpdate();
//                    if (contador > 0) {
//                        response.setContentType("text/plain");
//                        response.setCharacterEncoding("UTF-8");
//                        response.getWriter().write("mod");
//                    }
//                    System.out.println("NUmero de reg afectados " + contador);
//                    request.getRequestDispatcher("../../menu/mostrarBebidas.jsp").forward(request, response);
                    break;

            }
        } else {
//            request.getRequestDispatcher("../../menu/mostrarBebidas.jsp").forward(request, response);

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

}
