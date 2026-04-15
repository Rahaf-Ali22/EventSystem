package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String faculty = request.getParameter("faculty");
            String department = request.getParameter("department");
            String admissionYearStr = request.getParameter("admission_year");

            if (name == null || email == null || password == null ||
                faculty == null || department == null || admissionYearStr == null ||
                name.isEmpty() || email.isEmpty() || password.isEmpty()) {

                response.sendRedirect("register.jsp?error=All fields are required");
                return;
            }

            int admissionYear = Integer.parseInt(admissionYearStr);

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setFaculty(faculty);
            user.setDepartment(department);
            user.setAdmissionYear(admissionYear);

            // 🔥 مهم: تحديد role
            user.setRole("student");

            UserDAO userDAO = new UserDAO();
            boolean isRegistered = userDAO.registerUser(user);

            if (isRegistered) {
                response.sendRedirect("login.jsp?success=Account Created Successfully");
            } else {
                response.sendRedirect("register.jsp?error=Registration Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Server Error");
        }
    }
}