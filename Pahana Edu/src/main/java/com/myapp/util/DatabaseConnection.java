package com.myapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.InputStream;
import java.util.Properties;

public class DatabaseConnection {
	private static String url;
    private static String username;
    private static String password;
    
    static {
        try {
            // Load database properties
            Properties props = new Properties();
            InputStream input = null;
            
            // Try multiple locations for the properties file
            String[] locations = {
                "database.properties",
                "/database.properties",
                "WEB-INF/database.properties",
                "/WEB-INF/database.properties"
            };
            
            for (String location : locations) {
                input = DatabaseConnection.class.getClassLoader().getResourceAsStream(location);
                if (input != null) {
                    System.out.println("Found database.properties at: " + location);
                    break;
                }
            }
            
            if (input != null) {
                props.load(input);
                url = props.getProperty("db.url");
                username = props.getProperty("db.username");
                password = props.getProperty("db.password");
                
                System.out.println("Database properties loaded successfully");
                System.out.println("Connecting to database: " + url);
                System.out.println("Username: " + username);
                System.out.println("Password provided: " + (password != null && !password.isEmpty()));
                
            } else {
                System.out.println("Database properties file not found, using default values");
                // Use correct database name and password
                url = "jdbc:mysql://localhost:3306/pahana_edu";
                username = "root";
                password = "root";
                
                System.out.println("Using fallback values:");
                System.out.println("Connecting to database: " + url);
                System.out.println("Username: " + username);
                System.out.println("Password provided: " + (password != null && !password.isEmpty()));
            }
            
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
