/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package zainab;

import com.mysql.jdbc.Connection;
import java.sql.*;
import java.sql.DriverManager;
/**
 *
 * @author Zainab
 */
public final class DB {
    
    public Connection c;
    private Statement st;
    public static DB db;
    
    private DB() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            this.c = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/CareZainab","root","");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static synchronized DB getC() {
        if ( db == null ) { db = new DB(); }
        return db;
    }

    public ResultSet query(String query) throws SQLException{
        st = db.c.createStatement();
        return st.executeQuery(query);
    }
    
    public int nonquery(String query) throws SQLException {
        st = db.c.createStatement();
        return st.executeUpdate(query);
    }
    
    public String SQLSafe(String str){
        str = str.trim();
        str = str.replaceAll("[']{1}", "''");
        str = str.replaceAll("[\\\\]{1}[x]{1}[0]{2}", "");
        str = str.replaceAll("[\\\\]{1}[x]{1}[1]{1}[a]{1}", "");
        str = str.replaceAll("[\\\\]{1}", "\\\\");
        return str;
    }
 
}
