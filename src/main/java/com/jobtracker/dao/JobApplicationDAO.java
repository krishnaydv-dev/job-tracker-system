package com.jobtracker.dao;

import com.jobtracker.model.JobApplication;
import com.jobtracker.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobApplicationDAO {

    // Add new job application
    public boolean addApplication(JobApplication application) {
        String sql = "INSERT INTO job_applications (user_id, company_name, job_role, status, date_applied, experience_years, job_description, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, application.getUserId());
            ps.setString(2, application.getCompanyName());
            ps.setString(3, application.getJobRole());
            ps.setString(4, application.getStatus());
            ps.setString(5, application.getDateApplied());
            ps.setInt(6, application.getExperienceYears());
            ps.setString(7, application.getJobDescription());
            ps.setString(8, application.getNotes());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("AddApplication error: " + e.getMessage());
            return false;
        }
    }

    // Get all applications of a specific user
    public List<JobApplication> getApplicationsByUserId(int userId) {
        List<JobApplication> applications = new ArrayList<>();
        String sql = "SELECT * FROM job_applications WHERE user_id = ? ORDER BY created_at DESC";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setCompanyName(rs.getString("company_name"));
                app.setJobRole(rs.getString("job_role"));
                app.setStatus(rs.getString("status"));
                app.setDateApplied(rs.getString("date_applied"));
                app.setExperienceYears(rs.getInt("experience_years"));
                app.setJobDescription(rs.getString("job_description"));
                app.setNotes(rs.getString("notes"));
                app.setCreatedAt(rs.getString("created_at"));
                applications.add(app);
            }
        } catch (SQLException e) {
            System.out.println("GetApplicationsByUserId error: " + e.getMessage());
        }
        return applications;
    }

    // Get single application by ID
    public JobApplication getApplicationById(int id) {
        String sql = "SELECT * FROM job_applications WHERE id = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                JobApplication app = new JobApplication();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setCompanyName(rs.getString("company_name"));
                app.setJobRole(rs.getString("job_role"));
                app.setStatus(rs.getString("status"));
                app.setDateApplied(rs.getString("date_applied"));
                app.setExperienceYears(rs.getInt("experience_years"));
                app.setJobDescription(rs.getString("job_description"));
                app.setNotes(rs.getString("notes"));
                return app;
            }
        } catch (SQLException e) {
            System.out.println("GetApplicationById error: " + e.getMessage());
        }
        return null;
    }

    // Update application
    public boolean updateApplication(JobApplication application) {
        String sql = "UPDATE job_applications SET company_name=?, job_role=?, status=?, date_applied=?, experience_years=?, job_description=?, notes=? WHERE id=?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, application.getCompanyName());
            ps.setString(2, application.getJobRole());
            ps.setString(3, application.getStatus());
            ps.setString(4, application.getDateApplied());
            ps.setInt(5, application.getExperienceYears());
            ps.setString(6, application.getJobDescription());
            ps.setString(7, application.getNotes());
            ps.setInt(8, application.getId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("UpdateApplication error: " + e.getMessage());
            return false;
        }
    }

    // Delete application
    public boolean deleteApplication(int id) {
        String sql = "DELETE FROM job_applications WHERE id = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("DeleteApplication error: " + e.getMessage());
            return false;
        }
    }

    // Get all applications (for admin)
    public List<JobApplication> getAllApplications() {
        List<JobApplication> applications = new ArrayList<>();
        String sql = "SELECT * FROM job_applications ORDER BY created_at DESC";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setCompanyName(rs.getString("company_name"));
                app.setJobRole(rs.getString("job_role"));
                app.setStatus(rs.getString("status"));
                app.setDateApplied(rs.getString("date_applied"));
                app.setExperienceYears(rs.getInt("experience_years"));
                app.setJobDescription(rs.getString("job_description"));
                app.setNotes(rs.getString("notes"));
                app.setCreatedAt(rs.getString("created_at"));
                applications.add(app);
            }
        } catch (SQLException e) {
            System.out.println("GetAllApplications error: " + e.getMessage());
        }
        return applications;
    }

    // Get application counts by status for dashboard
    public int getCountByStatus(int userId, String status) {
        String sql = "SELECT COUNT(*) FROM job_applications WHERE user_id = ? AND status = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("GetCountByStatus error: " + e.getMessage());
        }
        return 0;
    }
}