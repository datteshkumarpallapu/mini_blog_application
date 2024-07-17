<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    session = request.getSession(false);
    if (session == null || !"Admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        h2, h3 {
            color: #ff6600; /* Orange color */
        }

        form {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #ff6600;
            border-radius: 5px;
            background-color: #f9f9f9;
            width: 300px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #ff6600;
        }

        input[type="text"], textarea, input[type="file"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #ff6600;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #e65c00;
        }

        .post {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            width: 300px;
            background-color: #f9f9f9;
        }

        .post h4 {
            color: #ff6600;
        }

        .post img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .post video {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .post form {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
    <h2>Admin Dashboard</h2>
    <form action="CreatePostServlet" method="post" enctype="multipart/form-data">
        <label>Title:</label>
        <input type="text" name="title" required><br>
        <label>Content:</label>
        <textarea name="content" required></textarea><br>
        <label>Image:</label>
        <input type="file" name="image"><br>
        <label>Video:</label>
        <input type="file" name="video"><br>
        <input type="submit" value="Create Post">
    </form>
    <h3>Existing Posts</h3>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog_app", "root", "Dattesh@1");
            String sql = "SELECT * FROM blog_posts ORDER BY created_at DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String content = resultSet.getString("content");
                String imagePath = resultSet.getString("image_path");
                String videoPath = resultSet.getString("video_path");
    %>
                <div class="post">
                    <h4><%= title %></h4>
                    <p><%= content %></p>
                    <% if (imagePath != null && !imagePath.isEmpty()) { %>
                        <img src="<%= imagePath %>" alt="Image"><br>
                    <% } %>
                    <% if (videoPath != null && !videoPath.isEmpty()) { %>
                        <video controls>
                            <source src="<%= videoPath %>" type="video/mp4">
                        </video><br>
                    <% } %>
                    <form action="DeletePostServlet" method="post">
                        <input type="hidden" name="postId" value="<%= id %>">
                        <input type="submit" value="Delete">
                    </form>
                </div>
    <%
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
