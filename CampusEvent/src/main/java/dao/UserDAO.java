package dao;

import model.User;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // 🔹 Register (موجود عندك)
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users (name, email, password, faculty, department, admission_year, role, is_blocked) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getFaculty());
            stmt.setString(5, user.getDepartment());
            stmt.setInt(6, user.getAdmissionYear());
            stmt.setString(7, user.getRole());
            stmt.setBoolean(8, user.isBlocked());

            int rowsInserted = stmt.executeUpdate();

            return rowsInserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🔹 Login (اللي أضفناه)
    public User loginUser(String email, String password) {

        User user = null;

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFaculty(rs.getString("faculty"));
                user.setDepartment(rs.getString("department"));
                user.setAdmissionYear(rs.getInt("admission_year"));
                user.setRole(rs.getString("role"));
                user.setBlocked(rs.getBoolean("is_blocked"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}