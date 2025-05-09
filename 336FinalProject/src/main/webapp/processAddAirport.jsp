<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String airportID = request.getParameter("aircraftID");
String city = request.getParameter("city");
String state = request.getParameter("state");



try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	
	PreparedStatement ps = con.prepareStatement("INSERT INTO Airport (Airport_ID, City, State) " + 
	"VALUES (?, ?, ?)");
	
	ps.setString(1, airportID);
	ps.setString(2, city);	
	ps.setString(3, state);	
	ps.executeUpdate();
	
	con.close();
	response.sendRedirect("repEditInfo.jsp");

	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>