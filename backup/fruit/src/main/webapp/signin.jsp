<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" type="text/css" href="Signin.css">
</head>
<body class="signin_body">
    <div class="center">
        <div class="signin" id="signinDiv">
            <h1>Sign In</h1>
           <!--  <form action="loginservlet" method="post">
                 Enter your email/phone no : <br>
                <input type="text" name="user"><br>
                Enter Password : <br>
                <input type="password" name="pass"><br>
                <a href="">Forget Password</a><br>-->
                <a href="customersignin.jsp">
                <input type="submit" value="Sign In as Customer"></a><br>
                <a href="farmersignin.jsp">
                <input type="submit" value="Sign In as Farmer"></a><br><br>
                </form>
                OR <br>
                <form action="signup.jsp">
                <input type="submit" value="Sign Up"><br>
            </form>
        </div>
    </div>
</body>
</html>