Blog Application with User Roles and Authentication

Project Overview
This project is a web application designed to manage blog posts with user roles and authentication. The application supports two user roles: Admin and Viewer.

Technologies Used:

Backend: Java Servlets
Frontend: JSP (JavaServer Pages)
Database: MySQL
Libraries: BCrypt for password hashing

Features:

User Registration and Login
User Registration: Users can register with their name, email, password, and role (Admin/Viewer).
User Login: Users can log in with their email and password.
Password Security: Passwords are hashed using BCrypt before being stored in the database.
Session Management: User sessions are managed to keep track of logged-in users and their roles.

Admin Dashboard:

Create Blog Posts: Admins can create new blog posts with a title, content, and optional image/video uploads.
Update Blog Posts: Admins can update existing blog posts.
Delete Blog Posts: Admins can delete blog posts.
Viewer Interface:

View Blog Posts: Viewers can browse all blog posts.
Search: Viewers can search for blog posts by title or date.
Pagination: Blog posts are displayed with pagination for better user experience.
Detailed View: Viewers can view individual blog posts in detail.
Security Enhancements
Password Hashing: Secure password hashing using BCrypt.
SQL Injection Prevention: Use of prepared statements to prevent SQL injection attacks.
Database Setup:

Create a MySQL database and user table:
sql

CREATE DATABASE blog_app;
USE blog_app;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Viewer') NOT NULL
);

CREATE TABLE blog_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image_path VARCHAR(255),
    video_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
Project Structure:



├── src
│   ├── main
│   │   ├── java
│   │   │   ├── RegisterServlet.java
│   │   │   ├── LoginServlet.java
│   │   │   ├── CreatePostServlet.java
│   │   │   ├── DeletePostServlet.java
│   │   │   ├── SearchServlet.java
│   │   ├── webapp
│   │   │   ├── register.jsp
│   │   │   ├── login.jsp
│   │   │   ├── admin-dashboard.jsp
│   │   │   ├── viewer-dashboard.jsp
│   │   │   ├── search-results.jsp
│   ├── resources
│   ├── web.xml
├── pom.xml



Usage

Register as Admin or Viewer: Go to the registration page (register.jsp) and create an account.
Login: Go to the login page (login.jsp) and log in with your credentials.
Admin Dashboard: If logged in as an Admin, you will be redirected to the Admin Dashboard where you can create, update, and delete blog posts.
Viewer Dashboard: If logged in as a Viewer, you will be redirected to the Viewer Dashboard where you can browse, search, and view blog posts.

Additional Information

Password Hashing: Passwords are securely hashed using BCrypt before being stored in the database.
SQL Injection Prevention: Prepared statements are used in the Servlets to prevent SQL injection attacks.
File Uploads: Uploaded images and videos are stored in the uploads directory.
