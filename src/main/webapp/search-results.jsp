<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
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

        div.result {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #f9f9f9;
        }

        h4 {
            color: #ff6600;
        }

        p {
            margin-bottom: 10px;
        }

        img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        video {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h2>Search Results</h2>
    <% ResultSet resultSet = (ResultSet) request.getAttribute("resultSet");

    while (resultSet.next()) {
        int id = resultSet.getInt("id");
        String title = resultSet.getString("title");
        String content = resultSet.getString("content");
        String imagePath = resultSet.getString("image_path");
        String videoPath = resultSet.getString("video_path");
    %>
    <div class="result">
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
    <% } %>
</body>
</html>
