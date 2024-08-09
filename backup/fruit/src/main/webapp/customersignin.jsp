<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="Signin.css">
</head>
<body class="signin_body">
    <div class="center">
        <div class="signin">
	        <form action="Clogin.jsp" method="post">
                <br><br>
                <h1>Welcome Customer</h1>
                Enter your email : <br>
                <input type="text" name="user"><br>
                Enter Password : <br>
                <input type="password" name="pass"><br>
                <a href="">Forget Password</a><br>
                <input type="submit" value="signin"><br>
            </form>
        </div>
    </div>
</body>
</html>