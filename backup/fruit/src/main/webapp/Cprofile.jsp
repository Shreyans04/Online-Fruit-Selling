<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <link rel="stylesheet" href="Signin.css"> 
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
    <div class="nav" style="margin-top:20px;">
        <ul>            
            <li><a href="Cprofile.jsp">Profile</a></li>
            <li><a href="logout.jsp" >Logout</a></li>
        </ul>
    </div>
    <main style="margin-top:30px;">
        <section>
            <div class="container">
				<%
                    
                    if (username != null) {
                        // Display user profile based on session data
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");
                            
                            int customerId = -1; // Default value if not found
                            String customerIdQuery = "SELECT customerId FROM customer WHERE customerId IN (SELECT customerId FROM clogin WHERE username = ?)";
                            try (PreparedStatement pstmt = con.prepareStatement(customerIdQuery)) {
                                pstmt.setString(1, username);
                                ResultSet rs = pstmt.executeQuery();
                                if (rs.next()) {
                                    customerId = rs.getInt("customerId");
                                }
                            }
                            
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
                                <h1 align=center>Customer Profile</h1>
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
                                </div>
                <%
                            } else {
                                out.println("<p>No farmer found with the specified username.</p>");
                            }
                        
                %>
                    </div>
        </section>
        <section>
            <h2>Order History</h2>
            <ul id="orderHistory">
                <%
                	pstmt = con.prepareStatement("select * from ordertb where customerId=?");
                	pstmt.setInt(1, customerId);                	
                	rs=pstmt.executeQuery();
                	
                	if(rs.next())
                	{
                		do{
                		out.println("<p> Product Name: "+rs.getString("productname")+"<br>Quantity: "+rs.getInt("quantity")+"<br>Total Price: "+rs.getInt("totalprice")+"</p>");
                		}while(rs.next());
                	}
                	else
                	{
                		out.println("No previous order history");	
                	}
                	
                %>
            </ul>
        </section>
        </main>
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
    
    <style>  

main {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

section {
    margin-bottom: 20px;
}

h2 {
    color: #333;
    border-bottom: 1px solid #ccc;
    padding-bottom: 5px;
    margin-bottom: 10px;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    margin-bottom: 5px;
}

footer {
margin-top: 20px;
	position: relative;
    background-color: #2b861b;
    color: #fff;
    text-align: center;
    padding: 10px 0;
    position: fixed;
    bottom: 0;
    width: 100%;
}
    </style>
</body>
</html>
<%
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
                    } else {
                        // Handle case where username attribute is not set in session
                        out.println("<p>User not logged in.</p>");
                    }
                    %>