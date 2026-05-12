<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial;
            background: linear-gradient(135deg, #f2f2f2, #64748b);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            width: 850px; /* 👈 كبرناها */
            background: white;
            padding: 35px; /* 👈 مساحات أكبر */
            border-radius: 18px;

            border: 2px solid #1A3263;

            box-shadow: 
                0 0 10px #1A3263,
                0 0 20px #1A3263,
                0 0 30px rgba(26,50,99,0.6);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #1A3263;
            font-size: 28px;
        }

        .form-row {
            display: flex;
            gap: 20px; /* 👈 مسافة أكبر */
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 6px;
            font-size: 14px;
            color: #1A3263;
            font-weight: bold;
        }

        input {
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            outline: none;
            transition: 0.3s;
            font-size: 14px;
        }

        input:focus {
            border-color: #1A3263;
            box-shadow: 0 0 6px #1A3263;
        }

        .register-btn {
            width: 100%;
            margin-top: 15px;
            padding: 14px;
            background: #1A3263;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;

            box-shadow:
                0 0 5px #1A3263,
                0 0 10px #1A3263,
                0 0 20px #1A3263;
        }

        .register-btn:hover {
            background: #64748b;
            color: #1A3263;

            box-shadow:
                0 0 10px #64748b,
                0 0 20px #64748b,
                0 0 30px #64748b;
        }

        .bottom-text {
            text-align: center;
            margin-top: 15px;
        }

        .bottom-text a {
            color: #1A3263;
            text-decoration: none;
            font-weight: bold;
        }

        .bottom-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-container">

    <h2>Create Account</h2>

    <form action="RegisterServlet" method="post">

        <div class="form-row">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <label>Faculty</label>
                <input type="text" name="faculty" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Department</label>
                <input type="text" name="department" required>
            </div>

            <div class="form-group">
                <label>Admission Year</label>
                <input type="number" name="admission_year" required>
            </div>
        </div>

        <button class="register-btn">Register</button>

    </form>

    <div class="bottom-text">
        Already have an account? <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>