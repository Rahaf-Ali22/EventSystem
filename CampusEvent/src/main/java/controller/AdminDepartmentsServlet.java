package controller;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Department;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-departments")
public class AdminDepartmentsServlet extends HttpServlet {

    private DepartmentDAO departmentDAO;

    @Override
    public void init() throws ServletException {
        departmentDAO = new DepartmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (!"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("delete".equalsIgnoreCase(action) && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                boolean deleted = departmentDAO.deleteDepartment(id);
                response.sendRedirect("admin-departments?" + (deleted ? "success=deleted" : "error=fail"));
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-departments?error=invalid");
                return;
            }
        }

        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departmentsList", departments);
        request.getRequestDispatcher("admin-departments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (!"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("home");
            return;
        }

        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("admin-departments?error=empty");
            return;
        }

        if (departmentDAO.existsByName(name.trim())) {
            response.sendRedirect("admin-departments?error=exists");
            return;
        }

        boolean added = departmentDAO.addDepartment(name.trim());
        response.sendRedirect("admin-departments?" + (added ? "success=added" : "error=fail"));
    }
}