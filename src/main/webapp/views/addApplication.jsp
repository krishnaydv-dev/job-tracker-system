<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Protect this page — must be logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Application - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4" style="max-width: 600px; margin: auto;">

        <h4 class="mb-4">Add New Job Application</h4>

        <!--
            form action points to ApplicationServlet
            action=save tells Servlet to save this application
            method=post because we are sending data
        -->
        <form action="${pageContext.request.contextPath}/application"
              method="post">

            <input type="hidden" name="action" value="save"/>

            <div class="mb-3">
                <label>Company Name</label>
                <input type="text" name="companyName"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Job Role</label>
                <input type="text" name="jobRole"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Status</label>
                <!--
                    Dropdown with our 4 status options
                    matches ENUM values in database exactly
                -->
                <select name="status" class="form-control">
                    <option value="APPLIED">Applied</option>
                    <option value="INTERVIEW">Interview</option>
                    <option value="SELECTED">Selected</option>
                    <option value="REJECTED">Rejected</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Date Applied</label>
                <input type="date" name="dateApplied"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Experience (Years)</label>
                <input type="number" name="experienceYears"
                       class="form-control" value="0" min="0"/>
            </div>

            <div class="mb-3">
                <label>Job Description</label>
                <textarea name="jobDescription"
                          class="form-control" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label>Notes</label>
                <textarea name="notes"
                          class="form-control" rows="2"></textarea>
            </div>

            <div class="d-flex gap-2">
                <button type="submit"
                        class="btn btn-primary">
                    Save Application
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