/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Bebida;
import beans.Comida;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author sebas
 */
@WebServlet(name = "menu", urlPatterns = {"/menu/*"})
public class menu extends HttpServlet {

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

        String nombreTabla = request.getPathInfo();
        String contextPath = request.getContextPath();
        System.out.println("contenido " + contextPath);

        //
        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();

        Statement st = conn.createStatement();
        ResultSet rs;

        String salida = "nada";
        switch (nombreTabla) {
            case "/bebidas":

                rs = st.executeQuery("SELECT * FROM BEBIDAS ORDER BY NOMBRE ASC");
                ArrayList<Bebida> bebidas = new ArrayList();
                while (rs.next()) {
                    double precio = rs.getDouble("precio");
                    Bebida bebida = new Bebida(precio, rs.getString("descripcion"), rs.getString("nombre"));
                    System.out.println(bebida);
                    bebidas.add(bebida);
                }

                rs.close();

                request.setAttribute("bebidas", bebidas);
                salida = "../mostrarBebidas.jsp";
                break;

            case "/comidas":

                rs = st.executeQuery("SELECT * FROM COMIDAS ORDER BY NOMBRE ASC");
                ArrayList<Comida> comidas = new ArrayList();
                while (rs.next()) {
                    double precio = rs.getDouble("precio");
                    Comida comida = new Comida(precio, rs.getString("descripcion"), rs.getString("nombre"));
                    System.out.println(comida);
                    comidas.add(comida);
                }

                request.setAttribute("comidas", comidas);
                salida = "../mostrarComidas.jsp";
                break;
        }
        conn.close();

        RequestDispatcher dispatcher = request.getRequestDispatcher(salida);
        dispatcher.forward(request, response);

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
            Logger.getLogger(menu.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(menu.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(menu.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(menu.class.getName()).log(Level.SEVERE, null, ex);
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
