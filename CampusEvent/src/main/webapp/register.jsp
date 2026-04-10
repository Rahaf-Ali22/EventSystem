<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
</head>
<body>
    <h2>User Registration</h2>

    <form action="register" method="post">
        <label>Name:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <label>Faculty:</label><br>
        <input type="text" name="faculty"><br><br>

        <label>Department:</label><br>
        <input type="text" name="department"><br><br>

        <label>Admission Year:</label><br>
        <input type="number" name="admissionYear"><br><br>

        <label>Role:</label><br>
        <select name="role" required>
            <option value="student">Student</option>
            <option value="organizer">Organizer</option>
            <option value="admin">Admin</option>
        </select><br><br>

        <button type="submit">Register</button>
    </form>
</body>
</html>