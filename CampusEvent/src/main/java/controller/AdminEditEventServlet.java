package controller;

import dao.CategoryDAO;
import dao.DepartmentDAO;
import dao.EventDAO;
import model.Category;
import model.Department;
import model.Event;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin-edit-event")
public class AdminEditEventServlet extends HttpServlet {

    private EventDAO eventDAO;
    private DepartmentDAO departmentDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        departmentDAO = new DepartmentDAO();
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

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("admin-events?error=invalid");
            return;
        }

        try {
            int eventId = Integer.parseInt(idParam);
            Event event = eventDAO.getEventById(eventId);

            if (event == null) {
                response.sendRedirect("admin-events?error=notfound");
                return;
            }

            List<Department> departments = departmentDAO.getAllDepartments();
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("event", event);
            request.setAttribute("departmentsList", departments);
            request.setAttribute("categoriesList", categories);

            request.getRequestDispatcher("admin-edit-event.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-events?error=invalid");
        }
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

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Date eventDate = Date.valueOf(request.getParameter("eventDate"));
            String location = request.getParameter("location");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            int seatsRemaining = Integer.parseInt(request.getParameter("seatsRemaining"));
            String departmentClub = request.getParameter("departmentClub");
            String category = request.getParameter("category");
            String eventType = request.getParameter("eventType");
            String status = request.getParameter("status");

            if (seatsRemaining > capacity) {
                response.sendRedirect("admin-edit-event?id=" + id + "&error=seats");
                return;
            }

            Event event = new Event();
            event.setId(id);
            event.setTitle(title);
            event.setDescription(description);
            event.setEventDate(eventDate);
            event.setLocation(location);
            event.setCapacity(capacity);
            event.setSeatsRemaining(seatsRemaining);
            event.setDepartmentClub(departmentClub);
            event.setCategory(category);
            event.setEventType(eventType);
            event.setStatus(status);

            boolean updated = eventDAO.updateEvent(event);

            if (updated) {
                response.sendRedirect("admin-events?success=updated");
            } else {
                response.sendRedirect("admin-edit-event?id=" + id + "&error=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-events?error=invalid");
        }
    }
}