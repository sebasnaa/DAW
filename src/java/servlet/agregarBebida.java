/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Bebida;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.InitialContext;
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
@WebServlet(name = "agregarBebida", urlPatterns = {"/agregarBebida"})
public class agregarBebida extends HttpServlet {

    @Resource(name = "myDatasource")
    private javax.sql.DataSource connectionPool;

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
            throws ServletException, IOException, Exception {

        response.setContentType("text/html;charset=UTF-8");

        Connection conn;
        PreparedStatement ps;
        int filasAfectadas = 0;

        String nombre = request.getParameter("nombre");
        String precio_str = request.getParameter("precio");
        double precio = Double.parseDouble(precio_str);

        String descripcion = request.getParameter("descripcion");

        if (precio <= 0.0) {
            throw new Exception("El precio debe ser mayor a 0");
        }

        Bebida bebida = new Bebida();
        bebida.setNombre(nombre);
        bebida.setPrecio(precio);
        bebida.setDescripcion(descripcion);
        
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        connectionPool = (javax.sql.DataSource) c.lookup("jdbc/myDatasourceBar");
        conn = connectionPool.getConnection();

        ps = conn.prepareStatement("INSERT INTO BEBIDAS (NOMBRE, PRECIO, DESCRIPCION) VALUES (?, ?,?)");
        ps.setString(1, bebida.getNombre());
        ps.setDouble(2, bebida.getPrecio());
        ps.setString(3, bebida.getDescripcion());

        filasAfectadas = ps.executeUpdate();
        String msg;
        if (filasAfectadas > 0) {
            msg = "<p> OK insercion correcta </p>";
        } else {
            msg = "<p> Se ha liado </p>";
        }
        

        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet agregarBebida</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet agregarBebida at " + request.getContextPath() + "</h1>");

            out.print(msg);
            out.print("<button> <a href=\"index.html\">Volver</a> </button>");
            out.println("</body>");
            out.println("</html>");
        }

        ps.close();
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
        } catch (Exception ex) {
            Logger.getLogger(agregarBebida.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(agregarBebida.class.getName()).log(Level.SEVERE, null, ex);
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
