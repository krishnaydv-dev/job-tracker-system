<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center
            align-items-center min-vh-100">
    <div class="card shadow p-4" style="width: 400px;">

        <h3 class="text-center mb-4">Job Tracker Login</h3>

        <!-- Error message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

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

            <button type="submit"
                    class="btn btn-primary w-100">Login</button>
        </form>

        <p class="text-center mt-3">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/views/register.jsp">
                Register here
            </a>
        </p>

    </div>
</div>

</body>
</html>