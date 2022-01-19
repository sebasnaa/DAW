/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.UsuarioDAO;
import beans.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.scene.control.Alert;
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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author sebas
 */
@WebServlet(name = "login", urlPatterns = {"/login/*"})
public class login extends HttpServlet {

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
            throws ServletException, IOException, NamingException, SQLException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getRequestURI();
        //Lo uso para saber si el crear cuenta ha sido correcto

        Connection conn;
        //se crea la conexion con el pool mediante un recurso
        Context c = new InitialContext();
        recurso = (javax.sql.DataSource) c.lookup("jdbc/myDatasource");
        conn = recurso.getConnection();

        Statement st = conn.createStatement();
        ResultSet rs;

        PreparedStatement pr = null;
        RequestDispatcher rd;

        int estadoCreacionCuenta;

        HttpSession session = request.getSession(true);
        UsuarioDAO control = new UsuarioDAO();
        switch (accion) {

            case "/Bar/login":

                rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);

                break;

            case "/Bar/login/crearCuenta":

                String nombreUsuario = request.getParameter("nombreUsuario");
                String correoUsuario = request.getParameter("correoUsuario");
                String passwordUsuario = request.getParameter("passwordUsuario");
                String rol = "admin";

                boolean estadoCreacion = control.agregarUsuario(nombreUsuario, correoUsuario, passwordUsuario, rol);

                if (estadoCreacion) {

                    session.setAttribute("flagCrearCuenta", "correcto");
                    response.sendRedirect("http://localhost:8080/Bar");
                } else {

                    session.setAttribute("flagCrearCuenta", "incorrecto");
                    response.sendRedirect("http://localhost:8080/Bar/login");
                }

                break;

            case "/Bar/login/Acceder":
                estadoCreacionCuenta = 0;
                String nombreUsuarioLog = request.getParameter("nombreUsuarioLogin");
                String passwordUsuarioLog = request.getParameter("passwordUsuarioLogin");
                System.out.println(nombreUsuarioLog + " " + passwordUsuarioLog);

                Usuario usuarioSession = control.login(nombreUsuarioLog, passwordUsuarioLog);

                if (usuarioSession != null) {
                    session.setAttribute("usuarioSesion", usuarioSession);
                    request.getRequestDispatcher("/validUserlogin.jsp").forward(request, response);
                } else {
                    System.out.println("Entra en usuario no bueno");
                    request.getRequestDispatcher("/invalidUserlogin.jsp").forward(request, response);
                }

//         
                break;

            case "/Bar/login/comprobar":

                String entrada = request.getParameter("correo");
                response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                if(control.comprobarUsuariounico(entrada)){
                    response.getWriter().write("existe correo/usuario");
                }
                

                break;

            default:

                break;
        }
        conn.close();

//        RequestDispatcher dispatcher = request.getRequestDispatcher(salida);
//        dispatcher.forward(request, response);
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
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
