<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*,java.sql.*"%>
<%! 
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	int i=0,pin=0;
	String ad,ct,st,cnt;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%		
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");
	pstmt=con.prepareStatement("insert into flocation(address,city,state,country,pincode) values(?,?,?,?,?)");
	
	ad=request.getParameter("add");
	ct=request.getParameter("ct");
	st=request.getParameter("st");
	cnt=request.getParameter("cntry");
	pin=Integer.parseInt(request.getParameter("pc"));
	
	pstmt.setString(1,ad);
	pstmt.setString(2,ct);
	pstmt.setString(3,st);
	pstmt.setString(4,cnt);
	pstmt.setInt(5,pin);
	
	i=pstmt.executeUpdate();
	if(i>0)
	{
		%>
		<script>
		alert("address inserted sucessfully");
		window.location.href = "fuser.html";
		</script>
		<%
	}
	else
	{
		%>
		<script>
		alert("address not inserted");
		</script>
		<%
	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</body>
</html>