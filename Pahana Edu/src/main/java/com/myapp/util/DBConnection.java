package com.myapp.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class DBConnection {

private static Properties dbProperties = null;
    
    // Load database properties from file
    static {
        loadDatabaseProperties();
    }
    
    private static void loadDatabaseProperties() {
        dbProperties = new Properties();
        
        // Try to load from resources directory first
        InputStream input = DBConnection.class.getClassLoader()
                .getResourceAsStream("database.properties");
        
        // If not found, try alternative path
        if (input == null) {
            input = DBConnection.class.getClassLoader()
                    .getResourceAsStream("/database.properties");
        }
        
        // If still not found, try from WEB-INF
        if (input == null) {
            input = DBConnection.class.getResourceAsStream("/database.properties");
        }
        
        if (input != null) {
            try {
                dbProperties.load(input);
                System.out.println("Database properties loaded successfully");
            } catch (IOException e) {
                System.err.println("Error loading database properties: " + e.getMessage());
                setDefaultProperties();
            } finally {
                try {
                    input.close();
                } catch (IOException e) {
                    System.err.println("Error closing input stream: " + e.getMessage());
                }
            }
        } else {
            System.err.println("Database properties file not found, using default values");
            setDefaultProperties();
        }
    }
    
    private static void setDefaultProperties() {
        dbProperties.setProperty("db.url", "jdbc:mysql://localhost:3306/pahana_edu");
        dbProperties.setProperty("db.username", "root");
        dbProperties.setProperty("db.password", "root");
        dbProperties.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            String driver = dbProperties.getProperty("db.driver");
            String url = dbProperties.getProperty("db.url");
            String username = dbProperties.getProperty("db.username");
            String password = dbProperties.getProperty("db.password");
            
            Class.forName(driver);
            
            System.out.println("Connecting to database: " + url);
            return DriverManager.getConnection(url, username, password);
            
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("Database driver error: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("Database connection error: " + e.getMessage());
        }
    }
    
    // Method to test database connection
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
    
    // Method to get database name
    public static String getDatabaseName() {
        return dbProperties.getProperty("db.name", "pahana_edu");
    }
    
    // Method to reload properties 
    public static void reloadProperties() {
        loadDatabaseProperties();
    }
    
}
