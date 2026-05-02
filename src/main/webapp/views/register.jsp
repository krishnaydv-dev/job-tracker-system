<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center
            align-items-center min-vh-100">
    <div class="card shadow p-4" style="width: 450px;">

        <h3 class="text-center mb-4">Create Account</h3>

        <!-- Error message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- Success message -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <div class="mb-3">
                <label>Full Name</label>
                <input type="text" name="fullName"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password"
                       class="form-control" required/>
            </div>

            <div class="mb-3">
                <label>Phone</label>
                <input type="text" name="phone"
                       class="form-control"/>
            </div>

            <button type="submit"
                    class="btn btn-success w-100">Register</button>
        </form>

        <p class="text-center mt-3">
            Already have an account?
            <a href="${pageContext.request.contextPath}/views/login.jsp">
                Login here
            </a>
        </p>

    </div>
</div>

</body>
</html>