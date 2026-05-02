package com.jobtracker.model;

public class JobApplication {

    private int id;
    private int userId;
    private String companyName;
    private String jobRole;
    private String status;
    private String dateApplied;
    private int experienceYears;
    private String jobDescription;
    private String notes;
    private String createdAt;

    // Default Constructor
    public JobApplication() {}

    // Parameterized Constructor
    public JobApplication(int id, int userId, String companyName, String jobRole,
                          String status, String dateApplied, int experienceYears,
                          String jobDescription, String notes) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.jobRole = jobRole;
        this.status = status;
        this.dateApplied = dateApplied;
        this.experienceYears = experienceYears;
        this.jobDescription = jobDescription;
        this.notes = notes;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getJobRole() { return jobRole; }
    public void setJobRole(String jobRole) { this.jobRole = jobRole; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDateApplied() { return dateApplied; }
    public void setDateApplied(String dateApplied) { this.dateApplied = dateApplied; }

    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    public String getJobDescription() { return jobDescription; }
    public void setJobDescription(String jobDescription) { this.jobDescription = jobDescription; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}