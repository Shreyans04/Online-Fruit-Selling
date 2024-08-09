<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*,javax.servlet.http.*"%>
<%!	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String fruitname,description,quantitystr,pricepustr,image;
	int i=0,quantity,pricepu;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String username = (String) session.getAttribute("username");
String type = (String) session.getAttribute("type");
int productId=0;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/backend","root","Dhoni@07");
		
		int farmerId = -1; // Default value if not found
        String customerIdQuery = "SELECT farmerId FROM farmer WHERE farmerId IN (SELECT loginId FROM flogin WHERE username = ?)";
        try (PreparedStatement pstmt = con.prepareStatement(customerIdQuery)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                farmerId = rs.getInt("farmerId");
            }
        }
		
		pstmt=con.prepareStatement("insert into product(fruitname,quantity,descrip,pricepu,image) values(?,?,?,?,?)");
		
		fruitname=request.getParameter("fruitname");
		quantitystr=request.getParameter("fquantity");	
		if (quantitystr != null && !quantitystr.isEmpty()) {
			quantity=Integer.parseInt(quantitystr);
		} 
		description=request.getParameter("fdescription");
		pricepustr=request.getParameter("fpricepu");
		if (pricepustr != null && !pricepustr.isEmpty()) {
			pricepu=Integer.parseInt(pricepustr);
		} 
		image=request.getParameter("fimage");
		
		pstmt.setString(1, fruitname);
		pstmt.setInt(2, quantity);
		pstmt.setString(3, description);
		pstmt.setInt(4, pricepu);
		pstmt.setString(5, image);
		
		i=pstmt.executeUpdate();
		
		if(1>0) {
			pstmt=con.prepareStatement("select max(productId) from product");
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				productId=rs.getInt(1);
			}
			
			pstmt=con.prepareStatement("insert into farmerproduct(farmerId, productId) values(?,?)");
			pstmt.setInt(1, farmerId);
			pstmt.setInt(2, productId);
			
			int i=pstmt.executeUpdate();
			
			if(i>0)	
			{
			%>
			<script>
			alert("product details uploaded");
			window.location.href = "main.jsp";
			</script>
			<% 
			}
		}
		
	}
	catch (Exception e) {
		out.println("Error: "+e);
	}
%>
</body>
</html>