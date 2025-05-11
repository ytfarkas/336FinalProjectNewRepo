<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>My Upcoming Flights</title>
  <style>
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background: #eee; }
    form { margin: 0; }
    button { padding: 4px 8px; }
  </style>
</head>
<body>

<%
  Integer acctNum = (Integer) session.getAttribute("user");
  if (acctNum == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/336AirlineProject",
    "root", "mysqlpassword");

  String sql =
    "SELECT b.Instance_ID, fs.Flight_Number, ac.Airline_Name, fa.Flight_Date, " +
    "       fs.Departure_Airport_ID, dep.City AS depCity, dep.State AS depState, fs.Departure_Time, " +
    "       fs.Arrival_Airport_ID, arr.City AS arrCity, arr.State AS arrState, fs.Arrival_Time, " +
    "       fa.Aircraft_ID, fa.Base_Price, b.Class, b.Price AS Booked_Fare " +
    "  FROM Bookings b " +
    "  JOIN Flight_Avalibility fa ON b.Instance_ID = fa.Instance_ID " +
    "  JOIN Flight_Schedule   fs ON fa.Flight_Number = fs.Flight_Number " +
    "  JOIN Airline_Company   ac ON fs.Airline_ID = ac.Airline_ID " +
    "  JOIN Airport           dep ON fs.Departure_Airport_ID = dep.Airport_ID " +
    "  JOIN Airport           arr ON fs.Arrival_Airport_ID   = arr.Airport_ID " +
    " WHERE b.Account_Number = ? AND fa.Flight_Date >= CURDATE() " +
    " ORDER BY fa.Flight_Date, fs.Departure_Time";

  PreparedStatement ps = con.prepareStatement(sql);
  ps.setInt(1, acctNum);
  ResultSet rs = ps.executeQuery();
%>

  <h2>My Upcoming Flights</h2>
  <table>
    <tr>
      <th>Booking ID</th>
      <th>Flight #</th>
      <th>Airline</th>
      <th>Date</th>
      <th>Departure</th>
      <th>Arrival</th>
      <th>Aircraft ID</th>
      <th>Base Fare ($)</th>
      <th>Class</th>
      <th>Booked Fare ($)</th>
      <th>Cancel</th>
    </tr>
<%
  while (rs.next()) {
    int instanceId = rs.getInt("Instance_ID");
%>
    <tr>
      <td><%= instanceId %></td>
      <td><%= rs.getString("Flight_Number") %></td>
      <td><%= rs.getString("Airline_Name") %></td>
      <td><%= rs.getDate("Flight_Date") %></td>
      <td>
        <%= rs.getString("Departure_Airport_ID") %>
        (<%= rs.getString("depCity") %>, <%= rs.getString("depState") %>)
        @ <%= rs.getTime("Departure_Time") %>
      </td>
      <td>
        <%= rs.getString("Arrival_Airport_ID") %>
        (<%= rs.getString("arrCity") %>, <%= rs.getString("arrState") %>)
        @ <%= rs.getTime("Arrival_Time") %>
      </td>
      <td><%= rs.getString("Aircraft_ID") %></td>
      <td><%= rs.getBigDecimal("Base_Price") %></td>
      <td><%= rs.getString("Class") %></td>
      <td><%= rs.getBigDecimal("Booked_Fare") %></td>
      <td>
        <form action="cancelBooking.jsp" method="post"
              onsubmit="return confirm('Are you sure you want to cancel this reservation?');">
          <input type="hidden" name="instanceID" value="<%= instanceId %>"/>
          <button type="submit">Cancel</button>
        </form>
      </td>
    </tr>
<%
  }
  rs.close();
  ps.close();
  con.close();
%>
  </table>

</body>
</html>
