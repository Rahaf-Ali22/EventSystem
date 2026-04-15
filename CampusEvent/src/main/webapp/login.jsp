<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f2f2f2, #f8c8dc);
            color: #1A3263;
        }

        .login-container {
            width: 400px;
            margin: 100px auto;
            background: #1A3263;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.12);
            color: white;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ffffff;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 2px solid #f8c8dc;
            border-radius: 8px;
            box-sizing: border-box;
            outline: none;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            box-shadow: 0 0 8px #f8c8dc;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: transparent;
            color: white;
            border: 2px solid #f8c8dc;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #f8c8dc;
            color: #1A3263;
            box-shadow: 0 0 10px #f8c8dc,
                        0 0 20px #f8c8dc,
                        0 0 40px #f8c8dc;
        }

        .error-message {
            text-align: center;
            color: #ffb3b3;
            font-weight: bold;
            margin-top: 15px;
        }

        .register-link {
            text-align: center;
            margin-top: 18px;
        }

        .register-link a {
            color: #f8c8dc;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>

    <form action="login" method="post">
        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <input class="btn" type="submit" value="Login">
    </form>

    <%
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) {
    %>
        <p class="error-message"><%= error %></p>
    <%
        }
    %>

    <div class="register-link">
        <p>Don’t have an account? <a href="register.jsp">Register</a></p>
    </div>
</div>

</body>
</html>