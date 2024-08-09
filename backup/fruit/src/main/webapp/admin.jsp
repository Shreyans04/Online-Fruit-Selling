<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 1200px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ccc;
        background-color: #f9f9f9;
    }
    h1, h2 {
        text-align: center;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 8px;
        border: 1px solid #ccc;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
<div class="container">
    <h1>Welcome Admin</h1>
    <hr>
    <div class="customer">
        <h2>Customer Details</h2>
        <table>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone Number</th>
                <th>Email ID</th>
            </tr>
            <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
                pstmt=con.prepareStatement("select * from customer");
                rs=pstmt.executeQuery();
                while(rs.next()) {
                    out.println("<tr><td>"+rs.getString("firstName")+"</td><td>"+rs.getString("lastName")+"</td><td>"+rs.getLong("phoneNumber")+"</td><td>"+rs.getString("emailId")+"</td></tr>");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
            %>
        </table>
        <hr>
    </div>

    <div class="farmer">
        <h2>Farmer Details</h2>
        <table>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone Number</th>
                <th>Email ID</th>
            </tr>
            <% 
            try {
                pstmt=con.prepareStatement("select * from farmer");
                rs=pstmt.executeQuery();
                while(rs.next()) {
                    out.println("<tr><td>"+rs.getString("firstName")+"</td><td>"+rs.getString("lastName")+"</td><td>"+rs.getLong("phoneNumber")+"</td><td>"+rs.getString("emailId")+"</td></tr>");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
            %>
        </table>
        <hr>
    </div>

    <div class="product">
        <h2>Product Details</h2>
        <table>
            <tr>
                <th>Fruit Name</th>
                <th>Quantity</th>
                <th>Price Per Unit</th>
            </tr>
            <% 
            try {
                pstmt=con.prepareStatement("select * from product");
                rs=pstmt.executeQuery();
                while(rs.next()) {
                    out.println("<tr><td>"+rs.getString("fruitname")+"</td><td>"+rs.getInt("quantity")+"</td><td>"+rs.getInt("pricepu")+"</td></tr>");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
            %>
        </table>
        <hr>
    </div>

    <div class="order">
        <h2>Order Details</h2>
        <table>
            <tr>
                <th>Fruit Name</th>
                <th>Quantity</th>
                <th>Total Price</th>
            </tr>
            <% 
            try {
                pstmt=con.prepareStatement("select * from ordertb");
                rs=pstmt.executeQuery();
                while(rs.next()) {
                    out.println("<tr><td>"+rs.getString("productname")+"</td><td>"+rs.getInt("quantity")+"</td><td>"+rs.getInt("totalprice")+"</td></tr>");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
            %>
        </table>
        <hr>
    </div>
</div>
</body>
</html>
