<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*,javax.servlet.http.*,java.util.*,javax.servlet.*" %>
<%!
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String productName = null;
    int productPrice = 0;
    int productQuantity = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add to Cart</title>
    </head>
<body>
<%
    String username = (String) session.getAttribute("username");

	String fruitname = request.getParameter("productName");
		
    if (username != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");

            // Get product details from the request
            productName = request.getParameter("productName");
            productPrice = Integer.parseInt(request.getParameter("productPrice"));
            productQuantity = Integer.parseInt(request.getParameter("quantity"));

            int customerId = -1; // Default value if not found
            String customerIdQuery = "SELECT customerId FROM customer WHERE customerId IN (SELECT customerId FROM clogin WHERE username = ?)";
            try (PreparedStatement pstmt = con.prepareStatement(customerIdQuery)) {
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    customerId = rs.getInt("customerId");
                }
            }

            int productId = -1; // Default value if not found
            String productIdQuery = "SELECT productId FROM product WHERE fruitname = ?";
            try (PreparedStatement pstmt = con.prepareStatement(productIdQuery)) {
                pstmt.setString(1, fruitname);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    productId = rs.getInt("productId");
                }
            }

            // Insert product into cart table
            pstmt = con.prepareStatement("INSERT INTO cart (customerId, productId, productname, quantity, pricepu) VALUES (?, ?, ?, ?, ?)");
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, productId);
            pstmt.setString(3, fruitname);
            pstmt.setInt(4, productQuantity);
            pstmt.setInt(5, productPrice);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to cart.jsp after adding product to cart
                response.sendRedirect("cart.jsp");
            } else {
                out.println("Failed to add product to cart.");
            }
        } catch (Exception e) {
            out.println("Error: " + e);
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                out.println("Error closing resources: " + e);
            }
        }
    } else {
        out.println("Username not Login");
    }
%>
</body>
</html>
