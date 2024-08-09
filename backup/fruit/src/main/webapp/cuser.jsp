<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!
	Connection con=null;
	PreparedStatement pstmt=null,pstmt1=null;
	ResultSet rs=null,Fid,Aid,Lid;
	String user,pass,cpass;
	int i=0,fid,aid,lid,a=0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
		
		pstmt=con.prepareStatement("select * from clogin where username=?");
		
		user=request.getParameter("email");	
		pstmt.setString(1, user);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			%>
			<script type="text/javascript">
			alert("User already present");
			window.location.href = "cuser.html";
			</script>
			<%
		} else {
		
		pstmt=con.prepareStatement("select * from customer where emailId=? ");
		
			
		pstmt.setString(1,user);
		
		rs=pstmt.executeQuery();
		
		if(rs.next())
		{
			%>
			<script>
			alert("email valid");
			</script>
			<%
		}
		else
		{
			%>
			<script>
			alert("invalid email");
			window.location.href = "cuser.html";
			</script>
			<%
		}
		
		pstmt=con.prepareStatement("insert into clogin(username,pass) values(?,?)");
		
		pass=request.getParameter("pass");
		cpass=request.getParameter("cpass");
		
		pstmt.setString(1, user);
		pstmt.setString(2, cpass);
		
		if(pass.equals(cpass))
		{
			i=pstmt.executeUpdate();
			
			if(i>0)
			{
				{
				pstmt1=con.prepareStatement("insert into customer_location_login values(?,?,?)");
						
				pstmt=con.prepareStatement("select max(customerId) from customer");
				Fid=pstmt.executeQuery();
				if(Fid.next())
				{
					fid=Fid.getInt(1);
					pstmt1.setInt(1, fid);
				}
				
				pstmt=con.prepareStatement("select max(locationId) from clocation");
				Aid=pstmt.executeQuery();
				if(Aid.next())
				{
					aid=Aid.getInt(1);
					pstmt1.setInt(2, aid);
				}
				
				pstmt=con.prepareStatement("select max(loginId) from clogin");
				Lid=pstmt.executeQuery();
				if(Lid.next())
				{
					lid=Lid.getInt(1);
					pstmt1.setInt(3, lid);
				}
				
				a=pstmt1.executeUpdate();
				}
				
				%>
				<script>
				alert("password created");
				window.location.href = "signin.jsp";
				</script>
				<%
			}
			else
			{
				%>
				<script>
				alert("password not created");
				</script>
				<%
			}
		}
		else
		{
			%>
			<script>
			alert("confirm password is different");
			window.location.href = "cuser.html";
			</script>
			<%
		}
		}		
	}
	catch(Exception e)
	{
		out.println("Error: "+e);	
	}
%>
</body>
</html>