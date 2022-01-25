/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 *
 * @author sebas
 */
@WebServlet(name = "editarProducto", urlPatterns = {"/editarProducto/*"})
public class editarProducto extends HttpServlet {

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
            throws ServletException, IOException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getRequestURI();

        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();

        String nombreOriginal = request.getParameter("nombreOriginal").trim();

        String nombreMod = request.getParameter("nombreMod");

        String precio_str = request.getParameter("precioMod");
        double precio = Double.parseDouble(precio_str);
        String descripcion = request.getParameter("desMod");

        PreparedStatement ps;
        int contador = 0;
        if (nombreMod != null && nombreOriginal != null) {
            switch (accion) {

                case "/Bar/editarProducto/bebida":

                    String sql = "UPDATE BEBIDAS SET  NOMBRE = ?, PRECIO = ?, DESCRIPCION = ? WHERE NOMBRE = ?";

                    ps = conn.prepareStatement(sql);
                    ps.setString(1, nombreMod);
                    ps.setDouble(2, precio);
                    ps.setString(3, descripcion);
                    ps.setString(4, nombreOriginal);

                    contador = ps.executeUpdate();
                    if (contador > 0) {
                        response.setContentType("text/plain");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write("mod");
                    }
                    System.out.println("NUmero de reg afectados " + contador);
                    ps.close();
                    conn.close();
                    break;

                case "/Bar/editarProducto/comida":
                    String sqlComida = "UPDATE COMIDAS SET  NOMBRE = ?, PRECIO = ?, DESCRIPCION = ? WHERE NOMBRE = ?";
                    System.out.println("entra");
                    ps = conn.prepareStatement(sqlComida);
                    ps.setString(1, nombreMod);
                    ps.setDouble(2, precio);
                    ps.setString(3, descripcion);
                    ps.setString(4, nombreOriginal);

                    contador = ps.executeUpdate();
                    if (contador > 0) {
                        response.setContentType("text/plain");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write("mod");
                    }
                    System.out.println("NUmero de reg afectados " + contador);
                    ps.close();
                    conn.close();
                    break;

            }
        } else {

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
        } catch (SQLException ex) {
            Logger.getLogger(editarProducto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(editarProducto.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(editarProducto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(editarProducto.class.getName()).log(Level.SEVERE, null, ex);
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
