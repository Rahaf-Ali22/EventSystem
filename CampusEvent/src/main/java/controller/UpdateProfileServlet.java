package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("loggedInUser");

        // 🔹 نجيب القيم من الفورم
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String faculty = request.getParameter("faculty");
        String department = request.getParameter("department");
        int admissionYear = Integer.parseInt(request.getParameter("admissionYear"));

        // 🔹 نعمل object جديد
        User user = new User();
        user.setId(sessionUser.getId());
        user.setName(name);
        user.setEmail(email);
        user.setFaculty(faculty);
        user.setDepartment(department);
        user.setAdmissionYear(admissionYear);

        // 🔹 تحديث بالداتابيس
        boolean updated = userDAO.updateUser(user);

        if (updated) {
            // 🔥 مهم جداً: نحدث ال session
            sessionUser.setName(name);
            sessionUser.setEmail(email);
            sessionUser.setFaculty(faculty);
            sessionUser.setDepartment(department);
            sessionUser.setAdmissionYear(admissionYear);

            session.setAttribute("loggedInUser", sessionUser);

            response.sendRedirect("profile?msg=updated");
        } else {
            response.sendRedirect("profile?error=fail");
        }
    }
}