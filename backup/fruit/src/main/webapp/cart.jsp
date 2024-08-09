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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="Signin.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="">
    <style>
        .card {
        	background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 15px;
            margin: 10px;
            width: 200px;
            height: 100%;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        }

        h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .quantity-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        .quantity-controls button {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            margin: 5px 2px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .quantity-controls input {
            width: 50px;
            text-align: center;
        }

        .delete-button {
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            margin-top: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .buy-button {
            background-color: #2196F3;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <title>Add Item to Cart</title>
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
    <div class="container">
        <h2>My Cart</h2>
        <div id="cart">
        <% 
            // Retrieve product details from the form
            
        
        if(username != null){
            try
        {            	           	
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
                
                pstmt=con.prepareStatement("select * from cart where customerId=?");
                pstmt.setInt(1, customerId);
                rs=pstmt.executeQuery();
                               
                if(rs.next())
                {
                	do{
            // Display the product details in the cart
            out.println("<div class=card>");
            
            out.println("<h3>" + rs.getString("productname") + "</h3>");
            out.println("<p>Price: Rs " + rs.getInt("pricepu") + "</p>");
            out.println("<p>Quantity: " + rs.getInt("quantity") + " kg</p>");
            out.println("<form action=delete.jsp>");
            
            out.println("<input type=hidden name=productName value="+ rs.getString("productname")+">");
            out.println("<input type=hidden name=productPrice value="+ rs.getInt("pricepu") +">");
            out.println("<input type=hidden name=productQuantity value="+ rs.getInt("quantity") +">"); 
            out.println("<button type=submit class=delete-button>Delete</button>");
            out.println("</form>");
            out.println("<form action=bill.jsp>");
            out.println("<input type=hidden name=productName value="+ rs.getString("productname")+">");
            out.println("<input type=hidden name=productPrice value="+ rs.getInt("pricepu") +">");
            out.println("<input type=hidden name=productQuantity value="+ rs.getInt("quantity") +">"); 
            out.println("<button type=submit class=buy-button>Buy</button>");
            out.println("</form></div>");
            
         /* Create cookies for each product
            Cookie productNameCookie = new Cookie("productName_" + rs.getInt("productId"), rs.getString("productName"));
            Cookie productPriceCookie = new Cookie("productPrice_" + rs.getInt("productId"), String.valueOf(rs.getInt("pricepu")));
            Cookie productQuantityCookie = new Cookie("productQuantity_" + rs.getInt("productId"), String.valueOf(rs.getInt("quantity")));

            // Set the cookies
            response.addCookie(productNameCookie);
            response.addCookie(productPriceCookie);
            response.addCookie(productQuantityCookie);*/
            
                }while(rs.next());
                }
                else
                {
                	out.println("Cart is empty");
                }
        }
        catch(Exception e)
        {
        	out.println("Error:"+e);
        	
        }
        }
        else
        	out.println("Login");
            // You can add the product to the user's cart in the database if needed
            // For example:
            // AddProductToCart(productName, productPrice, productQuantity);

            // You can also continue shopping or proceed to checkout
        %><!-- 
        </div>
        <button class="buy-button" onclick="window.location.href='bill.jsp'">Buy All</button>
    </div> -->
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
   

    <script>
    window.onload = function () {
        var cart = JSON.parse(localStorage.getItem('cart')) || [];
        var cartContainer = document.getElementById('cart');

        cart.forEach(function(product) {
            var card = createCard(product.name, product.price, product.quantity);
            cartContainer.appendChild(card);
        });
    }

    function createCard(name, price, quantity) {
        var card = document.createElement('div');
        card.className = 'card';
        card.innerHTML = `
            <h2>${name}</h2>
            <p>Price: ${price}</p>
            <div class="quantity-controls">
                <button onclick="decrementQuantity(this)">-</button>
                <input type="number" class="quantity-input" value="${quantity}" min="1" disabled>
                <button onclick="incrementQuantity(this)">+</button>
            </div>
            <button class="delete-button" onclick="deleteCard(this)">Delete</button>
        `;
        return card;
    }

    function deleteCard(button) {
        var card = button.parentNode;
        card.parentNode.removeChild(card);
        updateCart(); // Update the cart after deletion
    }

    function decrementQuantity(button) {
        var input = button.nextElementSibling;
        var currentValue = parseInt(input.value);
        if (currentValue > 1) {
            input.value = currentValue - 1;
            updateCart(); // Update the cart after quantity change
        }
    }

    function incrementQuantity(button) {
        var input = button.previousElementSibling;
        var currentValue = parseInt(input.value);
        input.value = currentValue + 1;
        updateCart(); // Update the cart after quantity change
    }

    function buyAllItems() {
        var cart = JSON.parse(localStorage.getItem('cart')) || [];
        if (cart.length > 0) {
            // Redirect to checkout page with item details
            if (cart.length === 1) {
                var item = cart[0];
                localStorage.setItem('itemToBuy', JSON.stringify(item));
            }
            // Clear the cart after buying all items
            localStorage.removeItem('cart');
            updateCart(); // Update the cart display after clearing
            window.location.href = 'bill.html'; // Redirect to bill.html
        } else {
            alert('Your cart is empty!');
        }
    }

    function updateCart() {
        // Update the cart in localStorage after any changes
        var cards = document.querySelectorAll('.card');
        var updatedCart = [];
        cards.forEach(function(card) {
            updatedCart.push({
                name: card.querySelector('h2').textContent,
                price: parseInt(card.querySelector('p').textContent.replace('Price: ', '')),
                quantity: parseInt(card.querySelector('.quantity-input').value)
            });
        });
        localStorage.setItem('cart', JSON.stringify(updatedCart));
    }
</script>
</body>
</html>
