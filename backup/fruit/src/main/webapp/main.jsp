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
    </div>
    <div class="menu" id="menuDiv">
        <div class="menu-list">
        </div>
         <div class="imgscroll">
            <div class="scroll-container" class="hidden">
                <img src="3.png">
                <img src="5.jpg">
                <img src="2.png">
            </div> 
        </div>
        <div class="features">
            <div class="container">
                <h1>Online Store</h1>
                <div class="benefits">
                    <div class="benefit">
                        <img src="4.png" alt="Delivery Truck">
                        <h2>FREE Delivery*</h2>
                        <p>On all orders above €500</p>
                    </div>
                    <div class="benefit">
                        <img src="7.png" alt="Clock">
                        <h2>6Hr Shipping*</h2>
                        <p>Delivering across Mumbai & Pune</p>
                    </div>
                    <div class="benefit">
                        <img src="8.png" alt="Return">
                        <h2>Easy Returns</h2>
                        <p>For items damaged during transit or quality issues</p>
                    </div>
                    <div class="benefit">
                        <img src="9.png" alt="Payment">
                        <h2>All Payment Modes</h2>
                        <p>Cards, UPI, Wallets, Net Banking and COD</p>
                    </div>
                    <div class="benefit">
                        <img src="10.png" alt="Support">
                        <h2>Customer Support</h2>
                        <p>Between 7am to 10pm, Monday to Saturday</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="fruit-background">
            <div class="fruitcontainer">
                
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

                
            	</div>
            <br>
            <div class="tagline">
                <p>Satisfaction of Farmer and Customer!!!!</p>
            </div>
        </div>
    </div>
    </div>


    <!-- testimonials  -->

    <div style="min-height: 350px;" id="c1">
        <span class="subHeading">
              <h2>Why Shop From Shetkari Bagg</h2>
            </span>
            <div class="testimonial-cards-container" >
                <div class="card-container" id="card1">
                    <div class="card">
                        <div class="front">
                            <img src="19.png"><br>
                            <span class="testimonialName">Kisan Trace</span><br>
                            <span>"Trace the Farmer where your order come from."
                   
                    </span>
                        </div>
                        <div class="back">
                            <img src="19.png">
                            <br><span class="testimonialName">Keslie O.</span><br>
                            <span>"Trace the Farmer where your order come from."
                    </span>
                        </div>
                    </div>
                </div>
                <div class="card-container">
                    <div class="card">
                        <div class="front">
                            <img src="20.png">
                            <br><span class="testimonialName">Clean & Grade</span><br>
                            <span class="testimonialText">"Post plucking ,each produce is cleaning and graded by experts."
                    </span>
                        </div>
                        <div class="back">
                            <img src="20.png">
                            <br><span class="testimonialName">Clean & Grade</span><br>
                            <span class="testimonialText">"Post plucking ,each produce is cleaning and graded by experts."
                    </span>
                        </div>
                    </div>
                </div>
                <div class="card-container">
                    <div class="card">
                        <div class="front">
                            <img src="13.png">
                            <br><span class="testimonialName">Highest Assortment</span><br>
                            <span>"250+ Fresh Fruits and Vegetables along with 100+ traditionally handmade snacks."        
                    </span>
                        </div>
                        <div class="back">
                            <img src="13.png">
                            <br><span class="testimonialName">Highest Assortment</span><br>
                            <span>"250+ Fresh Fruits and Vegetables along with 100+ traditionally handmade snacks."        
                    </span>
                        </div>
                    </div>
                </div>
                <div class="card-container">
                    <div class="card">
                        <div class="front">
                            <img src="14.jpg">
                            <br><span class="testimonialName">Naturally Grown </span><br>
                            <span>All our vegetable & fruits are naturally grown in natural environment."
                    </span>
                        </div>
                        <div class="back">
                            <img src="14.jpg">
                            <br><span class="testimonialName">Naturally Grown </span><br>
                            <span>All our vegetable & fruits are naturally grown in natural environment."
                    </span>
                        </div>
                    </div>
                </div> 
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
    
</body>
</html>