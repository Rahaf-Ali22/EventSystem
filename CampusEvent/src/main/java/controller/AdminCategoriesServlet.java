package controller;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.User;

import java.io.IOException;
import java.util.List;


public class AdminCategoriesServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
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
                boolean deleted = categoryDAO.deleteCategory(id);
                response.sendRedirect("admin-categories?" + (deleted ? "success=deleted" : "error=fail"));
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-categories?error=invalid");
                return;
            }
        }

        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categoriesList", categories);
        request.getRequestDispatcher("admin-categories.jsp").forward(request, response);
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
            response.sendRedirect("admin-categories?error=empty");
            return;
        }

        if (categoryDAO.existsByName(name.trim())) {
            response.sendRedirect("admin-categories?error=exists");
            return;
        }

        boolean added = categoryDAO.addCategory(name.trim());
        response.sendRedirect("admin-categories?" + (added ? "success=added" : "error=fail"));
    }
}