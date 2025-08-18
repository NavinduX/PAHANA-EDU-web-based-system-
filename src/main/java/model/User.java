package model;

public class User {
    private int userId;
    private String username;
    private String password;
    private String role;

    public User() {}

    public User(int userId, String username, String password, String role) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    // Validation methods
    public boolean isValidUsername() {
        return username != null && !username.trim().isEmpty() && username.trim().length() >= 3;
    }
    
    public boolean isValidPassword() {
        return password != null && !password.trim().isEmpty() && password.trim().length() >= 8;
    }
    
    public boolean isValidUser() {
        return isValidUsername() && isValidPassword() && role != null && !role.trim().isEmpty();
    }
    
    // Password strength validation
    public boolean isStrongPassword() {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        
        String pass = password.trim();
        return pass.length() >= 8 && pass.length() <= 20;
    }
    
    // Username format validation
    public boolean isValidUsernameFormat() {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        
        String user = username.trim();
        // Username should be 3-20 characters, alphanumeric and underscore only
        return user.matches("^[a-zA-Z0-9_]{3,20}$");
    }
}

