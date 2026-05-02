package com.jobtracker.dao;

import com.jobtracker.model.User;
import com.jobtracker.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Register a new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            String hashedPassword = BCrypt.hashpw(
                    user.getPassword(), BCrypt.gensalt());

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("Register error: " + e.getMessage());
            return false;
        }
    }

    // Login - validate email and password
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (BCrypt.checkpw(password, storedPassword)) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(storedPassword);
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                    return user;
                } else {
                    System.out.println("Password mismatch!");
                }
            } else {
                System.out.println("No user found with email: " + email);
            }

        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return null;
    }

    // Get user by ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println("GetUserById error: " + e.getMessage());
        }
        return null;
    }

    // Get all users for admin
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'STUDENT'";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("GetAllUsers error: " + e.getMessage());
        }
        return users;
    }

    // Check if email already exists
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("EmailExists error: " + e.getMessage());
        }
        return false;
    }
}