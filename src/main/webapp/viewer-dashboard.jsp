<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    session = request.getSession(false);
    if (session == null || !"Viewer".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Viewer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #ff6600; /* Orange color */
        }

        form {
            margin-bottom: 20px;
        }

        input[type="text"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #ff6600;
            color: #fff;
            padding: 8px 20px;
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
            background-color: #f9f9f9;
        }

        .post h4 {
            color: #ff6600;
        }

        .post p {
            margin-bottom: 10px;
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
    </style>
</head>
<body>
    <h2>Viewer Dashboard</h2>
    <form action="SearchServlet" method="get">
        <input type="text" name="query" placeholder="Search by title or date">
        <input type="submit" value="Search">
    </form>
    <%
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog_app", "root", "password");
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
        <% if (imagePath != null) { %>
        <img src="<%= imagePath %>" alt="Image" width="100"><br>
        <% } %>
        <% if (videoPath != null) { %>
        <video width="320" height="240" controls>
            <source src="<%= videoPath %>" type="video/mp4">
        </video><br>
        <% } %>
    </div>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
