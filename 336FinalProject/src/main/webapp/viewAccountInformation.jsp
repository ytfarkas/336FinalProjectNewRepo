<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	int accountNumber = (Integer) session.getAttribute("user");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String accountInfo = "SELECT Account_Number, First_Name, Last_Name, Username, Password, SSN, Role "
		+ "FROM Account WHERE Account_Number = ?";

		PreparedStatement accountData = con.prepareStatement(accountInfo);
		accountData.setInt(1, accountNumber);
		ResultSet rs = accountData.executeQuery();

		while (rs.next()) {
			int accountNumberData = rs.getInt("Account_Number");
			String firstName = rs.getString("First_Name");
			String lastName = rs.getString("Last_Name");
			String username = rs.getString("Username");
			String password = rs.getString("Password");
			String ssn = rs.getString("SSN");
			String role = rs.getString("Role");

			out.println("Account Number: " + accountNumberData + "<br>");
			out.println("First Name: " + firstName + "<br>");
			out.println("Last Name: " + lastName + "<br>");
			out.println("Username: " + username + "<br>");
			out.println("Password: " + password + "<br>");
			out.println("SSN: " + ssn + "<br>");
			out.println("Role: " + role + "<br><br>");
		}

	} catch (Exception e) {
		out.println(e.getMessage());
	}
	%>

</body>
</html>