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
<link rel="stylesheet" type="text/css" href="contentdetails.css">
<link rel="stylesheet" type="text/css" href="Signin.css">
<title>Product Details</title>
</head>
<body>
    <div class="header" id="homeDiv">
        <div class="l1">
            <div class="logo">
                <h1 id="name">Shetkari Bagg</h1>
            </div>            
            <input type="text" id="search" placeholder="Search for Products ">
            <button class="cart-button">
                <i class='bx bxs-cart-add'></i>
                My Cart
            </button>
            <a href="signin.html" target="_self">
                <input type="button" onclick="shownSignIn()">
            </a>
            <button class="location-button" id="locationBtn">location
            </button>
        </div>
        <div class="l2">
            <b><a href="Main.html" target="_self">Home</a></b>
            <b><a href="Fruits.html" target="_self">Fruits</a></b>
            <b><a href="AamMahotsav.html" target="_self">AamMahotsav</a></b>
            <b><a href="dryfruit.html " target="_self">Dry Fruits</a></b>
        </div>
    </div>
<div class="container">
    <div class="product">
        <img src="product-image.jpg" alt="Product Image">
        <div class="product-details">
        <%
        	a="grapes";
        	try {
        		Class.forName("com.mysql.cj.jdbc.Driver");
        		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
        		
        		pstmt=con.prepareStatement("select * from product");
        		
        		
        		rs=pstmt.executeQuery();
        		
        		if(rs.next())
        		{
        			  				
        				out.println("<h2 id=fname>"+rs.getString("fruitname")+"</h2><br>");
        				out.println("<p id=desc>Description: "+rs.getString("descrip")+"</p>");
        				out.println("<p>Price: <p id=price>"+rs.getInt("pricepu")+"</p></p>");
        			
        		}
        		else {
        			out.println("Data not found");
        		}
        	} catch (Exception e) {
        		out.println("Error: "+e);
        	}
        %>
        <form id="addToCartForm">
    <label for="quantity">Quantity:</label>
    <button type="button" id="decrement">-</button>
    <input type="number" id="quantity" name="quantity" value="1" min="1" required>
    <button type="button" id="increment">+</button>
    <button type="submit" class="add-to-cart">Add to Cart</button>
</form>
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

</script>
        </div>
        <script>
        document.getElementById('addToCartForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var quantity = document.getElementById('quantity').value;
            var productName = document.getElementById('fname').textContent;
            var productPrice = document.getElementById('price').textContent;
            var product = { name: productName, price: productPrice, quantity: quantity };
            var cart = JSON.parse(localStorage.getItem('cart')) || [];
            cart.push(product);
            localStorage.setItem('cart', JSON.stringify(cart));
            window.location.href = 'cart.html';
        });

    </script>
    
</div>


<footer class="footer1">
    <p>&copy; 2024, Shetkari Bagg | <a href="#">Privacy Policy</a> | <a href="#">Sitemap</a> | <a href="#">Terms & Conditions</a></p>
</footer>

</body>
</html>
