
package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {
    private static Connection con;
    public static Connection getConnection() {
        
        try {
            //drive class load
            if (con == null) {
                
                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","root");
            }
             
        } catch(Exception e) {
            e.printStackTrace();
        }
        return con;
    }
    
}
