package com.jobtracker.dao;

import com.jobtracker.model.Resume;
import com.jobtracker.util.DBConnection;

import java.sql.*;

public class ResumeDAO {

    // Save resume details to database
    public boolean saveResume(Resume resume) {
        String sql = "INSERT INTO resumes (user_id, file_name, file_path) VALUES (?, ?, ?)";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, resume.getUserId());
            ps.setString(2, resume.getFileName());
            ps.setString(3, resume.getFilePath());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("SaveResume error: " + e.getMessage());
            return false;
        }
    }

    // Get resume by user ID
    public Resume getResumeByUserId(int userId) {
        String sql = "SELECT * FROM resumes WHERE user_id = ? ORDER BY uploaded_at DESC LIMIT 1";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Resume resume = new Resume();
                resume.setId(rs.getInt("id"));
                resume.setUserId(rs.getInt("user_id"));
                resume.setFileName(rs.getString("file_name"));
                resume.setFilePath(rs.getString("file_path"));
                resume.setUploadedAt(rs.getString("uploaded_at"));
                return resume;
            }
        } catch (SQLException e) {
            System.out.println("GetResumeByUserId error: " + e.getMessage());
        }
        return null;
    }

    // Delete old resume when user uploads new one
    public boolean deleteResumeByUserId(int userId) {
        String sql = "DELETE FROM resumes WHERE user_id = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("DeleteResume error: " + e.getMessage());
            return false;
        }
    }
}