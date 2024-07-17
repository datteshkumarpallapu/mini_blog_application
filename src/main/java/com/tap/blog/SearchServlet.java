package main.java.com.tap.blog;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog_app", "root", "Dattesh@1");
            String sql = "SELECT * FROM blog_posts WHERE title LIKE ? OR created_at LIKE ? ORDER BY created_at DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            ResultSet resultSet = statement.executeQuery();

            request.setAttribute("resultSet", resultSet);
            request.getRequestDispatcher("search-results.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Search failed");
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
