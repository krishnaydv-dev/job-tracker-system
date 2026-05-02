<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Application - Job Tracker</title>
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
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52,152,219,0.25);
        }
        .form-label { font-size: 14px; font-weight: 500; }
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
            <a href="${pageContext.request.contextPath}/application?action=add"
               class="active">
                <i class="bi bi-plus-circle"></i> Add Application
            </a>
            <a href="${pageContext.request.contextPath}/application?action=list">
                <i class="bi bi-list-ul"></i> My Applications
            </a>
            <a href="${pageContext.request.contextPath}/views/uploadResume.jsp">
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
                <h4 class="mb-0">Add New Application</h4>
                <small class="text-muted">
                    Track a new job application
                </small>
            </div>
        </div>

        <!-- Form Card -->
        <div class="card shadow-sm"
             style="max-width: 700px;">
            <div class="card-body p-4">

                <form action="${pageContext.request.contextPath}/application"
                      method="post">
                    <input type="hidden" name="action" value="save"/>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-building me-1"></i>
                                Company Name
                            </label>
                            <input type="text"
                                   name="companyName"
                                   class="form-control"
                                   placeholder="e.g. Google, Amazon"
                                   required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-person-badge me-1"></i>
                                Job Role
                            </label>
                            <input type="text"
                                   name="jobRole"
                                   class="form-control"
                                   placeholder="e.g. Software Developer"
                                   required/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-flag me-1"></i>
                                Status
                            </label>
                            <select name="status"
                                    class="form-control">
                                <option value="APPLIED">Applied</option>
                                <option value="INTERVIEW">Interview</option>
                                <option value="SELECTED">Selected</option>
                                <option value="REJECTED">Rejected</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-calendar me-1"></i>
                                Date Applied
                            </label>
                            <input type="date"
                                   name="dateApplied"
                                   class="form-control"
                                   required/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-award me-1"></i>
                            Experience (Years)
                        </label>
                        <input type="number"
                               name="experienceYears"
                               class="form-control"
                               value="0" min="0"
                               style="max-width: 150px;"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-file-text me-1"></i>
                            Job Description
                        </label>
                        <textarea name="jobDescription"
                                  class="form-control"
                                  rows="3"
                                  placeholder="Brief description of the job role...">
                        </textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">
                            <i class="bi bi-sticky me-1"></i>
                            Notes
                        </label>
                        <textarea name="notes"
                                  class="form-control"
                                  rows="2"
                                  placeholder="Any personal notes about this application...">
                        </textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit"
                                class="btn btn-primary px-4">
                            <i class="bi bi-check-circle me-1"></i>
                            Save Application
                        </button>
                        <a href="${pageContext.request.contextPath}/dashboard"
                           class="btn btn-outline-secondary px-4">
                            Cancel
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>