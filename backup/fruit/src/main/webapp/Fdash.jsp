<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*,javax.servlet.http.*,java.util.*,javax.servlet.*" %>
<%!
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="Signin.css">
<title>Add Product</title>
<style>
.nav {
margin-top: 20px;
};
</style>
</head>
<body>
<div class="dashboard">
    <div class="header" id="homeDiv">
        <div class="l1">            
            <h1 id="name">Shetkari Bagg</h1>
            <input type="text" id="search" placeholder="Search for Products ">
            <button class="cart-button" onclick="window.location.href='cart.jsp'" id="cartbtn">
                <i class='bx bxs-cart-add'></i>
                My Cart
            </button>
            
            <!-- Check if user is logged in -->
            <% 
                String username = (String) session.getAttribute("username");
            	String type = (String) session.getAttribute("type");
                if (username != null) { // User is logged in
                	
                	if(type.equals("customer"))
                	{
            %>
                <!-- Show logout button -->
                <form method="post" action="logout.jsp">
                    <input type="button" class="login-btn" onclick="window.location.href='Cprofile.jsp'">
                </form>
            <% 
                	}
                	else if(type.equals("farmer"))
                	{
                		%>
                		<form method="post" action="logout.jsp">
                    <input type="button" class="login-btn" onclick="window.location.href='fprofile.jsp'">
                </form>
                		<%
                	}
                	} else { // User is not logged in
            %>
                <!-- Show login button -->
                <input type="button" class="login-btn" onclick="window.location.href='signin.jsp'">
            <% 
                }
            %>
            
            
            <button class="location-button">
                <i class='bx bx-location-plus' style="font-size: 25px;"></i><h3 id="locationBtn">
                Location</h3>
            </button>
        </div>       
        <div class="l2">
            <b><a href="main.jsp" target="_self">Home</a></b>
            <b><a href="Fruits.jsp" target="_self">Fruits</a></b>
            <b><a href="AamMahotsav.jsp" target="_self">AamMahotsav</a></b>
            <b><a href="dryfruit.jsp" target="_self">Dry Fruits</a></b>
            
        </div>
    </div>    
    </div>
    <div class="nav">
        <ul>            
            <li><a href="FDashboard.html">Add Products</a></li>
            <li><a href="fprofile.jsp">Profile</a></li>
            <li><a href="logout.jsp" >Logout</a></li>
        </ul>
    </div>
    <div class="content">
            <h2>Welcome, Farmer!</h2>
            <div class="form-container">
                <h2>Add Product</h2>
                <form action="fdashboard.jsp" method="post">
                    <!-- Form fields for adding a new product -->
                    <input type="text" id="name" name="fruitname" placeholder="Product Name" required><br>
                    <input type="number" id="quantity" name="fquantity" placeholder="Quantity available" required><br>
                    <textarea id="description" name="fdescription" rows="4" placeholder="Description" required></textarea><br>
                    <input type="number" id="price" name="fpricepu" placeholder="Price per unit (in Rs)" required><br>
                    <input type="text" id="image" name="fimage" placeholder="Image link" required><br>
                    <input type="submit" value="Submit">
                </form>
            </div>
        </div>
    <div class="copywrite" id="cpyDiv" style="align-items: center;justify-content: center;">
        <div style="display: flex;align-items: center;justify-content: center;">
        <h2>
        <span class="material-symbols-outlined" >
            copyright 
        </span>        
        &nbsp;Copywrite 2024 Ritesh Pawar & Shreyans Deolasi 
        </h2>
        </div>
        <p>Menu&nbsp; &nbsp; &nbsp; &nbsp;Contacts</p>
        <p>Home &nbsp; &nbsp; &nbsp; &nbsp;ShetkariBagg Corporate Office</p>
        <p>About Us&nbsp; &nbsp; &nbsp; &nbsp;Plot no. C-10, TTC Industrial Estate,</p>
        <p>Contact Us &nbsp; &nbsp; &nbsp; &nbsp;MIDC, Pawne, Koperkhairne, Navi Mumbai,Maharashtra - 400705</p>
        <p>FAQs&nbsp; &nbsp; &nbsp; &nbsp;1800 267 0997  </p>     
        <p>Why Shetkari Bagg?</p>
        <p>customercare@ShetkariBagg.in</p>    
        FOLLOW ON THESE APP&nbsp;&nbsp;<a href="#" style="--i:1"><i class='bx bxl-facebook'></i></a>
        <a href="#" style="--i:2"><i class='bx bxl-instagram'></i></a>  <br>          
        <p1> © 2024, Shetkari Bagg | Privacy Policy | Sitemap | Terms & Conditions</p1>
    </div>
    
</div>
</body>
</html>