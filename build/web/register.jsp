<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4CAF50, #81C784);
            transition: background 0.5s ease-in-out;
        }

        .card {
            animation: fadeInUp 0.6s ease;
            border-radius: 1rem;
            backdrop-filter: blur(10px);
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        input:focus {
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
        }

        a {
            text-decoration: none;
            color: #2e7d32;
        }

        a:hover {
            text-decoration: underline;
            color: #1b5e20;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

    <div class="card p-4 shadow-lg bg-white" style="width: 25rem;">
        <h3 class="text-center mb-4 text-success fw-bold">Register</h3>
        <form action="RegisterServlet" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Daftar</button>
        </form>
        <div class="text-center mt-3">
            <a href="login.jsp">Sudah punya akun? Login</a>
        </div>
    </div>

</body>
</html>
