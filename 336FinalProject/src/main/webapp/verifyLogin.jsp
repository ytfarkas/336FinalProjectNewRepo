<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String userid = request.getParameter("username");
String pwd = request.getParameter("password");
try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
	connectionPassword);

	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from account where username='" + userid + "' and password='" + pwd + "'");

	if (rs.next()) {
		String role = rs.getString("Role");
		int accountNumber = rs.getInt("Account_Number");
		session.setAttribute("user", accountNumber);
		session.setAttribute("role", role);
		response.sendRedirect("loginSucess.jsp");
	} else {
		out.println("Invalid password <a href='login.jsp'>Try Again</a>");
	}
	con.close();
} catch (Exception e) {
	out.println(e.getMessage());
}
%>