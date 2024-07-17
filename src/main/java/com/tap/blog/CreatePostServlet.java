package main.java.com.tap.blog;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/CreatePostServlet")
@MultipartConfig
public class CreatePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Part imagePart = request.getPart("image");
        String imagePath = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            String imageFileName = imagePart.getSubmittedFileName();
            String imageSavePath = "C:/Users/HP/eclipse-workspace/BlogApplication/src/main/webapp/uploads/images/" + imageFileName;
            imagePart.write(imageSavePath);
            imagePath = imageSavePath;
        }

        Part videoPart = request.getPart("video");
        String videoPath = null;
        if (videoPart != null && videoPart.getSize() > 0) {
            String videoFileName = videoPart.getSubmittedFileName();
            String videoSavePath = "uploads/videos/" + videoFileName;
            videoPart.write(videoSavePath);
            videoPath = videoSavePath;
        }

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog_app", "root", "Dattesh@1");
            String sql = "INSERT INTO blog_posts (title, content, image_path, video_path) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setString(3, imagePath);
            statement.setString(4, videoPath);
            statement.executeUpdate();
            response.sendRedirect("admin-dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Failed to create post");
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
