<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String aircraftID = request.getParameter("aircraftID");
String seats = request.getParameter("seats");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	
	PreparedStatement ps = con.prepareStatement("INSERT INTO Aircraft (Aircraft_ID, Seats) " + 
	"VALUES (?, ?)");
	
	ps.setString(1, aircraftID);
	ps.setString(2, seats);	
	ps.executeUpdate();
	
	con.close();
	response.sendRedirect("repEditInfo.jsp");

	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>