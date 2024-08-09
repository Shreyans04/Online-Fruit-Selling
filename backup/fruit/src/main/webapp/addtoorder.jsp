<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*"%>
<%!
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int i=0;
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

    if(username != null){
        try {            	           	
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
            
            pstmt=con.prepareStatement("insert into ordertb(customerId, productname, totalprice, quantity) values(?,?,?,?)");
            
            String fname=request.getParameter("productName");
            int tp=Integer.parseInt(request.getParameter("totalprice"));
            int q=Integer.parseInt(request.getParameter("productQuantity"));
            
            pstmt.setInt(1, customerId);
            pstmt.setString(2, fname);
            pstmt.setInt(3, tp);
            pstmt.setInt(4, q);
            
            i=pstmt.executeUpdate();
            
            if(i>0)
            {
                pstmt=con.prepareStatement("delete from cart where productname=? and quantity=?");
                
                String productname=request.getParameter("productName");
                int quantity=Integer.parseInt(request.getParameter("productQuantity"));
                
                pstmt.setString(1, productname);
                pstmt.setInt(2, quantity);
                
                i=pstmt.executeUpdate();
                
                if(i>0)
                {
                    response.sendRedirect("cart.jsp");
                }
            }
            else
            {
                out.println("not added");	
            }
        } catch(Exception e) {
            out.println("Error:"+e);		
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) { /* ignored */}
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) { /* ignored */}
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) { /* ignored */}
            }
        }
    }
%>
</body>
</html>
