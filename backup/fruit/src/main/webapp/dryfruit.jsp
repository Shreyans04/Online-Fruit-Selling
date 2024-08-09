<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String a;
%>


<!DOCTYPE html>
<html>
<head>
    <title>Dry Fruits</title>
    <link rel="stylesheet"
     href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" type="text/css" href="Signin.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="javascript" type="text/javascript" href="signin.js">
    <script>
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
    </div>
        <p align="center">
        <img src="11.jpg" alt="Image" width="1000" height="360">
      </p>
    
        <div class="fruit-background">
            <div class="fruitcontainer">
                <div class="line">
                    <div class="fruit" onclick="location.href=''" id="Dates Kimia">
                    <a href="Dates-Kimia.jsp" target="_self">
                    <img src="https://api.kisankonnect.com/kisankonnect/Images/ProductImage/2022090813184620220405122548Untitled%20design%20(52)-min%20(1).png" alt="Dates Kimia" height="190px" width="200px">
                    <p>Dates Kimia <button class="add-button">Add</button></p>
                    </a>
                    </div>
                    <div class="fruit"onclick="location.href=''" id="Apricot Dried">
                    <a href="Apricot-Dried.jsp" target="_self">
                    <img src="https://api.kisankonnect.com/kisankonnect/Images/ProductImage/20220906121604apricotdried-min.png" alt="Apricot Dried" height="190px" width="200px">
                    <p>Apricot Dried <button class="add-button">Add</button></p>
                    </a>
                    </div>
                    <div class="fruit" onclick="location.href=''" id="Badam">
                    <a href="Badam.jsp" target="_self">
                    <img src="https://diz7l2x0sn587.cloudfront.net/kisankonnect/Images/ProductImage/20220422103151Sonora-Badam-1kg.jpg" alt="Badam" height="190px" width="200px">
                    <p>Badam <button class="add-button">Add</button></p>
                    </a>
                    </div>
                    <div class="fruit" onclick="location.href=''" id="Walnut Kernel">
                        <a href="Walnut.jsp" target="_self">
                        <img src="https://api.kisankonnect.com/kisankonnect/Images/ProductImage/2022090612232020220530154725top-view-walnuts-bowl-rustic%20(1)-min.jpg" alt="Walnut Kernel" height="190px" width="200px">
                        <p>Walnut<button class="add-button">Add</button></p>
                        </a> 
                    </div>
                </div>
                </div>
                </div>
                <br>
                <div class="tagline">
                <p>Satisfaction of Farmer and Customer!!!!</p>  
                </div>
            </div>          
        </div>
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