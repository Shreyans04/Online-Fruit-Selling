<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%!	Connection con=null;
	PreparedStatement pstmt=null,phone=null;
	ResultSet rs=null;
	String fn, ln, fd, em, dt;
	long pn;
    int i = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body align=center>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");          
    
    pstmt = con.prepareStatement("insert into customer(firstName,lastName,phonenumber,emailId,registrationDate) values(?,?,?,?,?)");
    phone = con.prepareStatement("select * from customer where phonenumber=?");
    
    fn = request.getParameter("fN");
    ln = request.getParameter("lN");
    em = request.getParameter("eM");
    dt = request.getParameter("rD");

    pn = Long.parseLong(request.getParameter("pN"));          

    phone.setLong(1, pn);
    
    pstmt.setString(1, fn);
    pstmt.setString(2, ln);
    pstmt.setLong(3, pn);
    pstmt.setString(4, em);
    pstmt.setString(5, dt);
    
    rs=phone.executeQuery();
    
    if(rs.next()) {
    	%>
    	<script>
    	alert("phone number present");
    	window.location.href = "customer.html";
    	</script>
    	<%
    }
    else
    {
    	i = pstmt.executeUpdate();

    	if (i > 0) {
    		%>
    		<script>
    		alert("record inserted successfully");
    		window.location.href = "caddress.html";
    		</script>
    		<%    		
    	} else {
    		%>
    		<script>
    		alert("record not inserted");
    		</script>
    		<%
    	}	
    }
} catch (ClassNotFoundException | SQLException e) {
    out.println("An error occurred: " + e.getMessage());
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

%>
</body>
</html>