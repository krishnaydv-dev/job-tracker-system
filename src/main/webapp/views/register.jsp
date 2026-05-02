<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            min-height: 100vh;
        }
        .register-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .register-header {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            border-radius: 16px 16px 0 0;
            padding: 30px;
            text-align: center;
            color: white;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            font-size: 14px;
        }
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52,152,219,0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            font-weight: 500;
            color: white;
            width: 100%;
            transition: opacity 0.2s;
        }
        .btn-register:hover { opacity: 0.9; color: white; }
        .input-group-text {
            background: #f8f9fa;
            border-right: none;
            color: #6c757d;
        }
        .form-control-icon { border-left: none; }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center
            align-items-center min-vh-100 py-4">
    <div style="width: 100%; max-width: 450px;">

        <div class="card register-card">

            <!-- Header -->
            <div class="register-header">
                <i class="bi bi-person-plus-fill"
                   style="font-size: 2.5rem;"></i>
                <h4 class="mt-2 mb-1">Create Account</h4>
                <p class="mb-0" style="font-size: 14px; opacity: 0.8;">
                    Join Job Tracker today
                </p>
            </div>

            <!-- Form -->
            <div class="card-body p-4">

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger d-flex
                                align-items-center">
                        <i class="bi bi-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success d-flex
                                align-items-center">
                        <i class="bi bi-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/register"
                      method="post">

                    <div class="mb-3">
                        <label class="form-label"
                               style="font-size:14px;">
                            Full Name
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>
                            <input type="text"
                                   name="fullName"
                                   class="form-control form-control-icon"
                                   placeholder="Enter your full name"
                                   required/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"
                               style="font-size:14px;">
                            Email Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>
                            <input type="email"
                                   name="email"
                                   class="form-control form-control-icon"
                                   placeholder="Enter your email"
                                   required/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"
                               style="font-size:14px;">
                            Password
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-lock"></i>
                            </span>
                            <input type="password"
                                   name="password"
                                   class="form-control form-control-icon"
                                   placeholder="Create a password"
                                   required/>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label"
                               style="font-size:14px;">
                            Phone Number
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-telephone"></i>
                            </span>
                            <input type="text"
                                   name="phone"
                                   class="form-control form-control-icon"
                                   placeholder="Enter your phone number"/>
                        </div>
                    </div>

                    <button type="submit" class="btn-register">
                        <i class="bi bi-person-check me-2"></i>
                        Create Account
                    </button>

                </form>

                <hr class="my-4">

                <p class="text-center mb-0" style="font-size: 14px;">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/views/login.jsp"
                       class="text-primary fw-bold text-decoration-none">
                        Sign in here
                    </a>
                </p>

            </div>
        </div>

        <p class="text-center text-white mt-3"
           style="font-size: 12px; opacity: 0.7;">
            Job Tracker System &copy; 2026
        </p>

    </div>
</div>
</body>
</html>