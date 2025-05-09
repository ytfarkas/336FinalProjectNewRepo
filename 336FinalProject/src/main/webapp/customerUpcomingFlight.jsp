<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Upcoming Flights</title>
</head>
<body>
  <h2>Upcoming Flights</h2>

  <%
    Connection con       = null;
    PreparedStatement ps = null;
    ResultSet rs         = null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      con = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/336AirlineProject?serverTimezone=UTC",
          "root",
          "mysqlpassword"
      );
      String sql =
        "SELECT b.Account_Number, fa.Flight_Date, fs.Flight_Number " +
        "FROM Bookings b " +
        " JOIN Flight_Avalibility fa ON b.Instance_ID = fa.Instance_ID " +
        " JOIN Flight_Schedule   fs ON fa.Flight_Number = fs.Flight_Number " +
        "WHERE fa.Flight_Date >= CURDATE() " +
        "ORDER BY fa.Flight_Date";

      ps = con.prepareStatement(sql);
      rs = ps.executeQuery();

      while (rs.next()) {
  %>
        <p>
          Flight <strong><%= rs.getString("Flight_Number") %></strong>
          on <%= rs.getDate("Flight_Date") %>
          (Account # <%= rs.getInt("Account_Number") %>)
        </p>
  <%
      }

    } catch (Exception e) {
      out.println("<p style='color:red;'>Error retrieving upcoming flights: "
                  + e.getMessage() + "</p>");
      e.printStackTrace(new java.io.PrintWriter(out));
    } finally {
      try {
        if (rs  != null) rs.close();
        if (ps  != null) ps.close();
        if (con != null) con.close();
      } catch (SQLException closeEx) {
        out.println("<p style='color:red;'>Error closing resources: "
                    + closeEx.getMessage() + "</p>");
      }
    }
  %>

</body>
</html>
