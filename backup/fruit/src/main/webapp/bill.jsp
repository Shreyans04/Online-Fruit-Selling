<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*"%>
<%!
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet"
     href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" type="text/css" href="Signin.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="javascript" type="text/javascript" href="signin.js">
    <title>Bill</title>
    <style>
    .buy-button {
            background-color: #2196F3;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .bill{
        background-color: #ffffff;
        margin: 50px;
        width: fit-content;
        border-radius: 5px;
        border: 1px solid black;
        padding: 5px;
        justify-content: center;
        align-items: center;
        align-content: center;
        }
    </style>
    </head>
<body>
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
            <b><a href="Fruits.html" target="_self">Fruits</a></b>
            <b><a href="AamMahotsav.html" target="_self">AamMahotsav</a></b>
            <b><a href="dryfruit.html " target="_self">Dry Fruits</a></b>
            
        </div>
    </div>
    
        <div id="bill" class=bill align=center>
    <h1 align=center>Bill</h1>
    <hr>
    
     <%-- Retrieve and display selected products --%>
    <%
    
        String productname = request.getParameter("productName");
    	int price= Integer.parseInt(request.getParameter("productPrice")); 
    	int quantity = Integer.parseInt(request.getParameter("productQuantity"));
    	int total = price * quantity;
    	
    	 try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");
            
    	
    	 pstmt = con.prepareStatement("SELECT c.firstName, c.lastName, c.phoneNumber, c.emailId," +
      	       "cl.address, cl.city, cl.state, cl.country, cl.pincode "+
      	       "FROM clogin cln "+
      	       "JOIN customer_location_login cll ON cln.loginId = cll.loginId "+
      	       "JOIN customer c ON cll.customerId = c.customerId "+
      	       "JOIN clocation cl ON cll.locationId = cl.locationId "+
      	       "WHERE cln.username = ?");
      pstmt.setString(1, username);
      rs = pstmt.executeQuery();

      if (rs.next()) {
%>
          <h2 align=center>Customer Details</h2>
          <div class="profile">
              <label for="name">Name: <%= rs.getString("firstName") + " " + rs.getString("lastName") %></label>
              <p id="name"></p>

              <label for="email">Email: <%= rs.getString("emailId") %></label>
              <p id="email"></p>

              <label for="phone">Phone: <%= rs.getLong("phoneNumber") %></label>
              <p id="phone"></p>

              <label for="address">Address: <%= rs.getString("address") %></label>
              <p id="address"></p>

              <label for="city">City: <%= rs.getString("city") %></label>
              <p id="city"></p>

              <label for="state">State: <%= rs.getString("state") %></label>
              <p id="state"></p>

              <label for="country">Country: <%= rs.getString("country") %></label>
              <p id="country"></p>

              <label for="pincode">Pincode: <%= rs.getInt("pincode") %></label>
              <p id="pincode"></p>
              <hr>
              
          </div>
<%
      } else {
          out.println("<p>No farmer found with the specified username.</p>");
      }
    	 } catch(Exception e) {
             out.println("Error: " + e);
         } finally {
             try {
                 if (rs != null) rs.close();
                 if (pstmt != null) pstmt.close();
                 if (con != null) con.close();
             } catch (Exception ex) {
                 out.println("Error closing resources: " + ex);
             }
         }

    %>
                    <div class="product"> 
                    <h2> Product Details </h2>                   
                        <h3><%= productname %></h3>
                        <p>Price: Rs <%= price %></p>
                        <p>Quantity: <%= quantity %> kg</p>
                        <p> Total Bill: <%= total %> </p>
                        <form action=addtoorder.jsp>
                        <input type=submit class=buy-button value="Pay Now" onclick="alert('Order Placed')">
                        <input type=hidden name=productName value=<%= productname %>>
                        <input type=hidden name=totalprice value=<%= total %>>
                        <input type=hidden name=productQuantity value=<%= quantity %>>
                        </form>
                    </div>
    <%
               
    %>
    
        </div>
    <div class="copywrite" id="cpyDiv" style="align-items: center;justify-content: center;">
        <div style="display: flex;align-items: center;justify-content: center;">
        <span class="material-symbols-outlined" >
            copyright 
        </span>        
        &nbsp;Copywrite 2024 Ritesh Pawar & Shreyans Deolasi 
        <p>
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
</body>
</html>
