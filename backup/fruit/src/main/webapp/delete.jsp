<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*"%>
<%
	Connection con;
	PreparedStatement pstmt;
	int i;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String productname;
	int quantity;
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
		
		pstmt=con.prepareStatement("delete from cart where productname=? and quantity=?");
		
		productname=request.getParameter("productName");
		quantity=Integer.parseInt(request.getParameter("productQuantity"));
		
		pstmt.setString(1, productname);
		pstmt.setInt(2, quantity);
		
		i=pstmt.executeUpdate();
		
		if(i>0)
		{
			response.sendRedirect("cart.jsp");
		}
	}
	catch(Exception e)
	{
		out.println("Error :"+e);
	}
%>
</body>
</html>