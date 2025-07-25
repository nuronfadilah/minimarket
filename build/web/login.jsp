<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - MiniMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet"> <!-- Gaya kustom kamu -->
</head>
<body class="bg-login d-flex justify-content-center align-items-center vh-100">

    <div class="login-card card p-4 shadow-lg animate-fade-in">
        <h3 class="text-center mb-4 text-gradient">Login</h3>
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="text-center mt-3">
            <a href="register.jsp" class="text-decoration-none">Belum punya akun? <strong>Daftar</strong></a>
        </div>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mt-3" role="alert">Username atau password salah!</div>
        <% } %>
    </div>

</body>
</html>
