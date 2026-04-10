package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            int admissionYear = Integer.parseInt(request.getParameter("admissionYear"));
            String role = request.getParameter("role");

            User user = new User(name, email, password, faculty, department, admissionYear, role);

            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.registerUser(user);

            if (success) {
                response.getWriter().println("User registered successfully!");
            } else {
                response.getWriter().println("Registration failed from DAO.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Registration failed: " + e.getMessage());
        }
    }
}