<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobtracker.model.JobApplication" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
    // Get the application object that Servlet put in request
    // This has the existing data to pre-fill the form
    JobApplication app =
        (JobApplication) request.getAttribute("application");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Application - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4" style="max-width: 600px; margin: auto;">

        <h4 class="mb-4">Edit Job Application</h4>

        <form action="${pageContext.request.contextPath}/application"
              method="post">

            <input type="hidden" name="action" value="update"/>
            <!--
                We send the id so Servlet knows
                WHICH application to update in DB
            -->
            <input type="hidden" name="id"
                   value="<%= app.getId() %>"/>

            <div class="mb-3">
                <label>Company Name</label>
                <!--
                    value="<%= app.getCompanyName() %>"
                    pre-fills the form with existing data
                -->
                <input type="text" name="companyName"
                       class="form-control"
                       value="<%= app.getCompanyName() %>" required/>
            </div>

            <div class="mb-3">
                <label>Job Role</label>
                <input type="text" name="jobRole"
                       class="form-control"
                       value="<%= app.getJobRole() %>" required/>
            </div>

            <div class="mb-3">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="APPLIED"
                        <%= "APPLIED".equals(app.getStatus())
                            ? "selected" : "" %>>Applied</option>
                    <option value="INTERVIEW"
                        <%= "INTERVIEW".equals(app.getStatus())
                            ? "selected" : "" %>>Interview</option>
                    <option value="SELECTED"
                        <%= "SELECTED".equals(app.getStatus())
                            ? "selected" : "" %>>Selected</option>
                    <option value="REJECTED"
                        <%= "REJECTED".equals(app.getStatus())
                            ? "selected" : "" %>>Rejected</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Date Applied</label>
                <input type="date" name="dateApplied"
                       class="form-control"
                       value="<%= app.getDateApplied() %>"/>
            </div>

            <div class="mb-3">
                <label>Experience (Years)</label>
                <input type="number" name="experienceYears"
                       class="form-control"
                       value="<%= app.getExperienceYears() %>"/>
            </div>

            <div class="mb-3">
                <label>Job Description</label>
                <textarea name="jobDescription"
                          class="form-control" rows="3">
                    <%= app.getJobDescription() %>
                </textarea>
            </div>

            <div class="mb-3">
                <label>Notes</label>
                <textarea name="notes"
                          class="form-control" rows="2">
                    <%= app.getNotes() %>
                </textarea>
            </div>

            <div class="d-flex gap-2">
                <button type="submit"
                        class="btn btn-primary">
                    Update Application
                </button>
                <a href="${pageContext.request.contextPath}/dashboard"
                   class="btn btn-secondary">
                    Cancel
                </a>
            </div>

        </form>
    </div>
</div>
</body>
</html>