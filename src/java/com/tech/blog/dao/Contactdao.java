
package com.tech.blog.dao;

import com.tech.blog.entities.Contact;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Contactdao {
    private final Connection con;
    
    public Contactdao(Connection con) {
        this.con = con;
    }
    
    //method to inset contact information to database...
    public boolean saveContactDetails(Contact contact) {
        boolean f = false;
        try{
            String query = "insert into userquery(name, email, phone, query) values(?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            
            pstmt.setString(1, contact.getName());
            pstmt.setString(2, contact.getEmail());
            pstmt.setString(3, contact.getPhone());
            pstmt.setString(4, contact.getQuery());
            
            pstmt.executeUpdate();
            f = true;
            
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return f;
    }
    
    
}
