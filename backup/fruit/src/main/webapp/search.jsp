<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String a;
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shetkari Bagg</title>
    <link rel="stylesheet"
     href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" type="text/css" href="Signin.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="javascript" type="text/javascript" href="signin.js">
      <script>      
        function openCart() {
        	window.location.href = "cart.html";    
      	}		
        window.onload = function () {
            var selectedLocation = localStorage.getItem('selectedLocation');
            if (selectedLocation) {
                document.getElementById('locationBtn').textContent = selectedLocation;
            }
        }        
    </script>   
    
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
            <b><a href="Fruits.jsp" target="_self">Fruits</a></b>
            <b><a href="AamMahotsav.jsp" target="_self">AamMahotsav</a></b>
            <b><a href="dryfruit.jsp" target="_self">Dry Fruits</a></b>
            
        </div>

<% int i=0;       	
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
    
    pstmt=con.prepareStatement("select * from product");
    
    rs=pstmt.executeQuery();
    
    
    if(rs.next()) 
    { 
        out.println("<div class=line>")	;
        do {
            out.println("<div class=fruit >");
            out.println("<img src="+rs.getString("image")+" height=150px width=180px>");
            out.println("<h2><a href="+rs.getString("fruitname")+".jsp>"+rs.getString("fruitname")+"</a></h2>");
            out.println("<p>Price: "+rs.getInt("pricepu")+"</p>");
            out.println("</div>"); 
            i++;
            if(i%4 == 0) {
                out.println("</div><div class=line>");
            }
        }while(rs.next());   
        out.println("</div");
    }
    
}
catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>