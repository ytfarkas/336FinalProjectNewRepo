<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String accountnumber = request.getParameter("accountNumber");
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String username = request.getParameter("username");
String password = request.getParameter("password");
String ssn = request.getParameter("ssn");
String role = request.getParameter("role");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement userEditSql = con.prepareStatement("UPDATE Account SET First_Name = ?, Last_Name = ?, Username = ?, Password = ?, SSN = ?, Role= ?" + 
	"WHERE Account_Number = ?");
	
	userEditSql.setString(1, firstName);
	userEditSql.setString(2, lastName);	
	userEditSql.setString(3, username);	
	userEditSql.setString(4, password);	
	userEditSql.setString(5, ssn);
	userEditSql.setString(6, role);
	userEditSql.setString(7, accountnumber);
	userEditSql.executeUpdate();
	
	con.close();
	
	response.sendRedirect("adminHome.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>