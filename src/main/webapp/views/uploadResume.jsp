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
    ResumeDAO resumeDAO = new ResumeDAO();
    Resume existingResume = resumeDAO.getResumeByUserId(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Resume - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #2c3e50;
            position: sticky;
            top: 0;
        }
        .sidebar .brand {
            color: white;
            font-size: 18px;
            font-weight: 600;
            padding: 20px;
            border-bottom: 1px solid #34495e;
            display: block;
        }
        .sidebar a {
            color: #bdc3c7;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 20px;
            font-size: 14px;
            transition: all 0.2s;
        }
        .sidebar a:hover {
            background-color: #34495e;
            color: white;
        }
        .sidebar a.active {
            background-color: #34495e;
            color: white;
            border-left: 3px solid #3498db;
        }
        .sidebar .logout-link { color: #e74c3c !important; }
        .sidebar .logout-link:hover {
            background-color: #c0392b !important;
            color: white !important;
        }
        .upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            transition: all 0.2s;
            cursor: pointer;
        }
        .upload-area:hover {
            border-color: #3498db;
            background-color: #f0f8ff;
        }
        .resume-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px 20px;
            border-left: 4px solid #3498db;
        }
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <!-- Sidebar -->
    <div class="sidebar p-0" style="width: 240px; min-width: 240px;">
        <span class="brand">
            <i class="bi bi-briefcase-fill me-2"></i>Job Tracker
        </span>
        <div class="mt-2">
            <a href="${pageContext.request.contextPath}/dashboard">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/application?action=add">
                <i class="bi bi-plus-circle"></i> Add Application
            </a>
            <a href="${pageContext.request.contextPath}/application?action=list">
                <i class="bi bi-list-ul"></i> My Applications
            </a>
            <a href="${pageContext.request.contextPath}/views/uploadResume.jsp"
               class="active">
                <i class="bi bi-file-earmark-arrow-up"></i> Upload Resume
            </a>
        </div>
        <div style="position: absolute; bottom: 20px; width: 240px;">
            <a href="${pageContext.request.contextPath}/logout"
               class="logout-link">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4">

        <!-- Page Header -->
        <div class="d-flex align-items-center mb-4">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="btn btn-outline-secondary btn-sm me-3">
                <i class="bi bi-arrow-left"></i> Back
            </a>
            <div>
                <h4 class="mb-0">Upload Resume</h4>
                <small class="text-muted">
                    Upload your latest resume in PDF format
                </small>
            </div>
        </div>

        <div style="max-width: 600px;">

            <!-- Success Message -->
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success d-flex
                            align-items-center mb-4">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    Resume uploaded successfully!
                </div>
            <% } %>

            <!-- Current Resume Info -->
            <% if (existingResume != null) { %>
                <div class="resume-info mb-4">
                    <div class="d-flex align-items-center
                                justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-file-earmark-pdf-fill
                                      text-danger"
                               style="font-size: 2rem;"></i>
                            <div>
                                <p class="mb-0 fw-bold">
                                    <%= existingResume.getFileName() %>
                                </p>
                                <small class="text-muted">
                                    Uploaded:
                                    <%= existingResume.getUploadedAt() %>
                                </small>
                            </div>
                        </div>
                        <span class="badge bg-success">Active</span>
                    </div>
                </div>
            <% } %>

            <!-- Upload Form -->
            <div class="card shadow-sm">
                <div class="card-body p-4">

                    <form action="${pageContext.request.contextPath}/uploadResume"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="upload-area mb-4"
                             onclick="document.getElementById('resumeFile').click()">
                            <i class="bi bi-cloud-arrow-up"
                               style="font-size: 3rem; color: #3498db;"></i>
                            <h6 class="mt-3 mb-1">
                                Click to select your resume
                            </h6>
                            <p class="text-muted mb-0"
                               style="font-size: 13px;">
                                Only PDF files accepted — Max 5MB
                            </p>
                            <input type="file"
                                   id="resumeFile"
                                   name="resumeFile"
                                   accept=".pdf"
                                   style="display: none;"
                                   onchange="updateFileName(this)"
                                   required/>
                        </div>

                        <!-- Selected file name display -->
                        <div id="fileNameDisplay"
                             class="alert alert-info d-none mb-4">
                            <i class="bi bi-file-earmark-pdf me-2"></i>
                            <span id="fileName"></span>
                        </div>

                        <% if (existingResume != null) { %>
                            <div class="alert alert-warning"
                                 style="font-size: 13px;">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                Uploading a new resume will replace
                                your existing one.
                            </div>
                        <% } %>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            <i class="bi bi-cloud-arrow-up me-2"></i>
                            Upload Resume
                        </button>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function updateFileName(input) {
        if (input.files && input.files[0]) {
            document.getElementById('fileName').textContent =
                input.files[0].name;
            document.getElementById('fileNameDisplay')
                .classList.remove('d-none');
        }
    }
</script>

</body>
</html>