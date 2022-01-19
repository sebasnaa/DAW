/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import beans.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author sebas
 */
public class UsuarioDAO {

    static Connection conn = null;
    static ResultSet rs = null;

    public Usuario login(String correo, String password) throws NamingException {
        Statement stmt = null;
//        String searchQuery =
//               "select * from users where correo = "+ correo + " AND password='" + password + "'";
//        

        String searchQuery
                = "select * from usuarios where correo='"
                + correo
                + "' AND password='"
                + password
                + "'";
        try {
            conn = getRecurso().getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean existe = rs.next();
            if (!existe) {
                //mandar mensaje
                return null;
            } else {
                System.out.println("Existe usuario correcrto log");
                String nombreDAO = rs.getString("nombre");
                String correoDAO = rs.getString("correo");
                String passDAO = rs.getString("password");
                String rolDAO = rs.getString("rol");

                Usuario usuario = new Usuario(nombreDAO, correoDAO, passDAO, rolDAO);
                return usuario;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public boolean agregarUsuario(String nombreUsuario, String correoUsuario, String password, String rol) throws NamingException {

        System.out.println(nombreUsuario + " " + correoUsuario + " " + password + " " + rol);

        int estadoCreacionCuenta = 0;
        PreparedStatement pr = null;

        try {
            conn = getRecurso().getConnection();
            pr = conn.prepareStatement("INSERT INTO USUARIOS (NOMBRE, CORREO, PASSWORD,ROL) VALUES (?,?,?,?)");
            pr.setString(1, nombreUsuario);
            pr.setString(2, correoUsuario);
            pr.setString(3, password);
            pr.setString(4, rol);
            estadoCreacionCuenta = pr.executeUpdate();

            pr.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Fallo al crear Usuario");
        }

        if (estadoCreacionCuenta > 0) {
            System.out.println("Bien usuario");
            return true;
        } else {
            System.out.println("Mal usuario");
            return false;
        }
    }

    public boolean comprobarUsuariounico(String correoUsuario) throws NamingException {

        System.out.println(correoUsuario + " ");

        int estadoCreacionCuenta = 0;
        PreparedStatement pr = null;
        ResultSet rs = null;
        boolean state = false;
        try {
            conn = getRecurso().getConnection();
            pr = conn.prepareStatement("SELECT * FROM USUARIOS WHERE CORREO = ?");
            pr.setString(1, correoUsuario);
            rs = pr.executeQuery();

            state = rs.next();
            pr.close();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Fallo en comprobacion");
        }

        
        return state;
    }

    private DataSource getRecurso() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("jdbc/myDatasource");
    }

}
