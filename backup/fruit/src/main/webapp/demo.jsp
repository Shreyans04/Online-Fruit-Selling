<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.io.*,java.sql.*"%>
<%! 
    Connection con = null;
    PreparedStatement pstmt = null, phone = null, pstmt1 = null;
    ResultSet rs = null, Fid = null, Aid = null, Lid = null;
    String fn, ln, fd, em, dt, user, ad, ct, st, cnt, pass, cpass;
    long pn;
    int i = 0, fid, aid, lid, a;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
</head>
<body align="center">
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/backend", "root", "Dhoni@07");

    pstmt = con.prepareStatement("insert into Farmer(firstName, lastName, phonenumber, emailId, farmDetails, registrationDate) values(?,?,?,?,?,?)");
    phone = con.prepareStatement("select * from Farmer where phonenumber=?");

    fn = request.getParameter("fN");
    ln = request.getParameter("lN");
    fd = request.getParameter("fD");
    em = request.getParameter("eM");
    dt = request.getParameter("rD");

    pn = Long.parseLong(request.getParameter("pN"));

    phone.setLong(1, pn);

    pstmt.setString(1, fn);
    pstmt.setString(2, ln);
    pstmt.setLong(3, pn);
    pstmt.setString(4, em);
    pstmt.setString(5, fd);
    pstmt.setString(6, dt);

    rs = phone.executeQuery();

    if (rs.next()) {
        %>
        <script>
            alert("phone number present");
            window.location.href = "demo.html";
        </script>
        <%
    } else {
        i = pstmt.executeUpdate();

        if (i > 0) {
            pstmt = con.prepareStatement("insert into flocation(address, city, state, country, pincode) values(?,?,?,?,?)");

            ad = request.getParameter("add");
            ct = request.getParameter("ct");
            st = request.getParameter("st");
            cnt = request.getParameter("cntry");
            int pin = Integer.parseInt(request.getParameter("pc"));

            pstmt.setString(1, ad);
            pstmt.setString(2, ct);
            pstmt.setString(3, st);
            pstmt.setString(4, cnt);
            pstmt.setInt(5, pin);

            i = pstmt.executeUpdate();
            if (i > 0) {
                pstmt = con.prepareStatement("select * from flogin where username=?");

                user = request.getParameter("email");
                pstmt.setString(1, user);

                rs = pstmt.executeQuery();

                if (rs.next()) {
                    %>
                    <script type="text/javascript">
                        alert("User already present");
                        window.location.href = "demo.html";
                    </script>
                    <%
                } else {
                    pstmt = con.prepareStatement("select * from farmer where emailId=? ");

                    user = request.getParameter("email");
                    pstmt.setString(1, user);

                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        %>
                        <script>
                            alert("email valid");
                        </script>
                        <%
                    } else {
                        %>
                        <script>
                            alert("invalid email");
                            window.location.href = "fuser.html";
                        </script>
                        <%
                    }

                    pstmt = con.prepareStatement("insert into flogin(username, pass) values(?,?)");

                    pass = request.getParameter("pass");
                    cpass = request.getParameter("cpass");

                    pstmt.setString(1, user);
                    pstmt.setString(2, cpass);

                    if (pass.equals(cpass)) {
                        i = pstmt.executeUpdate();

                        if (i > 0) {
                            pstmt1 = con.prepareStatement("insert into farmer_location_login values(?,?,?)");

                            pstmt = con.prepareStatement("select max(farmerId) from farmer");
                            Fid = pstmt.executeQuery();
                            if (Fid.next()) {
                                fid = Fid.getInt(1);
                                pstmt1.setInt(1, fid);
                            }

                            pstmt = con.prepareStatement("select max(locationId) from flocation");
                            Aid = pstmt.executeQuery();
                            if (Aid.next()) {
                                aid = Aid.getInt(1);
                                pstmt1.setInt(2, aid);
                            }

                            pstmt = con.prepareStatement("select max(loginId) from flogin");
                            Lid = pstmt.executeQuery();
                            if (Lid.next()) {
                                lid = Lid.getInt(1);
                                pstmt1.setInt(3, lid);
                            }

                            a = pstmt1.executeUpdate();
                            %>
                            <script>
                                alert("password created");
                                window.location.href = "signin.jsp";
                            </script>
                            <%
                        } else {
                            %>
                            <script>
                                alert("password not created");
                            </script>
                            <%
                        }
                    }
                }
            } else {
                %>
                <script>
                    alert("record not inserted");
                </script>
                <%
            }
        }
    }
} catch (ClassNotFoundException | SQLException e) {
    out.println("An error occurred: " + e.getMessage());
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (pstmt1 != null) pstmt1.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
</body>
</html>
