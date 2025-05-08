<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String location = request.getParameter("location");
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
	
	PreparedStatement countPs = con.prepareStatement("select count(*) from account where role = ?" );
	countPs.setString(1, role);
	ResultSet rs = countPs.executeQuery();
	
	
	PreparedStatement ps = con.prepareStatement("INSERT INTO Account (First_Name, Last_Name, Username, Password, SSN, Role)" + 
	"VALUES (?, ?, ?, ?, ?, ?)");
	
	ps.setString(1, firstName);
	ps.setString(2, lastName);	
	ps.setString(3, username);	
	ps.setString(4, password);	
	ps.setString(5, ssn);
	ps.setString(6, role);
	ps.executeUpdate();
	
	con.close();
	if(location.equals("admin")){
		response.sendRedirect("adminHome.jsp");
		
	}else if (location.equals("register")){
		response.sendRedirect("login.jsp");

	}
	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>