package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    // Get DB Connection
    public static Connection getConnection() throws ClassNotFoundException, SQLException  {
    	String username = "root";
    	String password = "1234";
    	
    	// Try newer driver first, fall back to older one
    	try {
    	    Class.forName("com.mysql.cj.jdbc.Driver");
    	} catch (ClassNotFoundException e) {
    	    Class.forName("com.mysql.jdbc.Driver");
    	}
    	
    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookshop_db?characterEncoding=utf8&useSSL=false&serverTimezone=UTC", username, password);
    			
    	return con; 			
    }   
}
