<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobtracker.model.Resume" %>
<%@ page import="com.jobtracker.dao.ResumeDAO" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    // Check if user already has a resume
    // If yes, show current resume info
    ResumeDAO resumeDAO = new ResumeDAO();
    Resume existingResume = resumeDAO.getResumeByUserId(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Resume - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4"
         style="max-width: 550px; margin: auto;">

        <h4 class="mb-4">Upload Resume</h4>

        <!-- Show success message if redirected after upload -->
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                Resume uploaded successfully!
            </div>
        <% } %>

        <!-- Show existing resume if available -->
        <% if (existingResume != null) { %>
            <div class="alert alert-info">
                Current resume:
                <strong><%= existingResume.getFileName() %></strong>
                <br/>
                <small>Uploaded at: <%= existingResume.getUploadedAt() %></small>
            </div>
        <% } %>

        <!--
            enctype="multipart/form-data" is REQUIRED for file upload
            Without this, the file won't be sent to the server
        -->
        <form action="${pageContext.request.contextPath}/uploadResume"
              method="post"
              enctype="multipart/form-data">

            <div class="mb-3">
                <label>Select Resume (PDF only)</label>
                <!--
                    accept=".pdf" restricts file picker to PDFs only
                    name="resumeFile" is how Servlet identifies the file
                -->
                <input type="file"
                       name="resumeFile"
                       accept=".pdf"
                       class="form-control"
                       required/>
            </div>

            <div class="d-flex gap-2">
                <button type="submit"
                        class="btn btn-primary">
                    Upload Resume
                </button>
                <a href="${pageContext.request.contextPath}/dashboard"
                   class="btn btn-secondary">
                    Back to Dashboard
                </a>
            </div>

        </form>
    </div>
</div>
</body>
</html>