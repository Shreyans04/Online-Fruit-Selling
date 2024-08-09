<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*,javax.servlet.http.*"%>
<%! 
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String us,pw,type;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div align=center>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
		
		pstmt=con.prepareStatement("select * from flogin where username=? and pass=?");
		
		us=request.getParameter("user");
		pw=request.getParameter("pass");
		
		type="farmer";
		
		pstmt.setString(1, us);
		pstmt.setString(2, pw);
		
		rs=pstmt.executeQuery();
		
		if(rs.next())
		{
			 HttpSession s = request.getSession(true); // Get session object, create a new one if not exists
	         s.setAttribute("username", us);
			 s.setAttribute("type", type);
	%>
	<script>
		alert("Login SuccessFull");
		window.location.href = "fprofile.jsp";
	</script>
	<%
		} else {
	%>
	<script>
		alert("Invalid User");
		window.location.href = "signin.jsp";
	</script>
	<%
		}
	} catch (Exception e) {
		out.println("Error: "+e.getMessage());
	}
%>
</div>
</body>
</html>