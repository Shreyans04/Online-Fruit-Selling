
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String a;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="contentdetails.css">
<link rel="stylesheet" type="text/css" href="Signin.css">
<title>Product Details</title>
</head>
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
<div class="container">
    <div class="product">
        <%	
            		
        	a="Walnut";
        	try {
        		Class.forName("com.mysql.cj.jdbc.Driver");
        		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
        		
        		pstmt=con.prepareStatement("select * from product where fruitname=?");
        		
        		pstmt.setString(1, a);
        		
        		rs=pstmt.executeQuery();
        		
        		if(rs.next())
        		{
        			  	out.println("<img src="+rs.getString("image")+" alt=Product img>");	
        			  	out.println("<div class=product-details>");
        				out.println("<h2 id=fname>"+rs.getString("fruitname")+"</h2><br>");
        				out.println("<p id=desc>Description: "+rs.getString("descrip")+"</p>");
        				out.println("<p id=price>Price: "+rs.getInt("pricepu")+"</p>");
        				out.println("<p id=quan>Quantity Avaiable: "+rs.getInt("quantity")+"<br>");
        				out.println("</div>");       				
        				
        		}
        		else {
        			out.println("Data not found");
        		}
        	} catch (Exception e) {
        		out.println("Error: "+e);
        	}
        %>
    </div>
    <form id="addToCartForm" action=addtocart.jsp>
    <label for="quantity">Quantity:(in kg)</label>
    <button type="button" id="decrement">-</button>
    <input type="text" id="quantity" name="quantity" value="1" min="1" required>
    <button type="button" id="increment">+</button>
    <input type="hidden" name="productName" value="<%= rs.getString("fruitname") %>">
        <input type="hidden" name="productPrice" value="<%= rs.getInt("pricepu") %>">
        <input type="hidden" name="productQuantity" value="<%= request.getParameter("quantity") %>">
    <input type="submit" class="add-to-cart" value="Add to Cart" id="addToCart">    
    </form>    
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
    
<script>
document.getElementById('increment').addEventListener('click', function() {
    var quantity = document.getElementById('quantity');
    quantity.value = parseInt(quantity.value) + 1;
});

document.getElementById('decrement').addEventListener('click', function() {
    var quantity = document.getElementById('quantity');
    if (parseInt(quantity.value) > 1) {
        quantity.value = parseInt(quantity.value) - 1;
    }
});

document.getElementById('addToCartForm').addEventListener('submit', function(event) {
    var selectedQuantity = parseInt(document.getElementById('quantity').value);
    var availableQuantity = parseInt(document.getElementById('quan').innerText.split(":")[1].trim());
    
    if (selectedQuantity > availableQuantity) {
        alert("Selected quantity exceeds available quantity. Please select a lower quantity.");
        event.preventDefault(); // Prevent form submission
    }
});

</script>
</body>
</html>