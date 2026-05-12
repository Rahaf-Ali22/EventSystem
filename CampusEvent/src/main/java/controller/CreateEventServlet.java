package controller;

import dao.CategoryDAO;
import dao.DepartmentDAO;
import dao.EventDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Category;
import model.Department;
import model.Event;
import model.User;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import factory.EventFactory;

@WebServlet("/create-event")
@MultipartConfig
public class CreateEventServlet extends HttpServlet {

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

        User organizer = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equalsIgnoreCase(organizer.getRole())) {
            response.sendRedirect("home");
            return;
        }

        List<Department> departments = departmentDAO.getAllDepartments();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("departmentsList", departments);
        request.setAttribute("categoriesList", categories);

        request.getRequestDispatcher("create-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User organizer = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equalsIgnoreCase(organizer.getRole())) {
            response.sendRedirect("home");
            return;
        }

        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Date eventDate = Date.valueOf(request.getParameter("eventDate"));
            String location = request.getParameter("location");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String departmentClub = request.getParameter("departmentClub");
            String category = request.getParameter("category");
            String eventType = request.getParameter("eventType");

   
            Event event = EventFactory.createEvent(eventType);

            event.setTitle(title);
            event.setDescription(description);
            event.setEventDate(eventDate);
            event.setLocation(location);
            event.setCapacity(capacity);
            event.setCreatedBy(organizer.getId());
            event.setStatus("OPEN");
            event.setSeatsRemaining(capacity);
            event.setDepartmentClub(departmentClub);
            event.setCategory(category);

           
            Part filePart = request.getPart("image");

            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {

                String uploadPath = getServletContext().getRealPath("/uploads");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); 
                }

                fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

                filePart.write(uploadPath + File.separator + fileName);

                System.out.println("SAVED TO: " + uploadPath + File.separator + fileName);

                event.setImage(fileName);
            }
            
            boolean created = eventDAO.createEvent(event);

            if (created) {
                response.sendRedirect("organizer-dashboard?success=created");
            } else {
                response.sendRedirect("create-event?error=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("create-event?error=invalid");
        }
    }
}