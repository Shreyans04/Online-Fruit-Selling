<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
    <% 
        // Get the session and invalidate it
        HttpSession s = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    %>
    <h1>Thankyou for visiting Shetkari Bagg. You have been logged out successfully.</h1>
    <p><a href="main.jsp">Login Again</a></p>
</body>
</html>
