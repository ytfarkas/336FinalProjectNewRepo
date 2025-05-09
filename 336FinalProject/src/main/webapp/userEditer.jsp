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
	String accountNumber = request.getParameter("accountNumber");
	String firstName = "";
	String lastNames = "";
	String username = "";
	String password = "";
	String ssn = "";
	String role = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		PreparedStatement userInfoPs = con.prepareStatement(
		"SELECT First_Name, Last_Name, Username, Password, SSN, Role FROM Account WHERE Account_Number = ?");

		userInfoPs.setString(1, accountNumber);
		ResultSet userInfoRs = userInfoPs.executeQuery();

		if (!userInfoRs.next()){
			out.println("Account Does Not Exist");
		}
		else {
			firstName = userInfoRs.getString("First_Name");
			lastNames = userInfoRs.getString("Last_Name");
			username = userInfoRs.getString("Username");
			password = userInfoRs.getString("Password");
			ssn = userInfoRs.getString("SSN");
			role = userInfoRs.getString("Role");

		
	%>
	<form action="processUserEdit.jsp" method="POST">
		First Name: <input type="text" name="firstName" value="<%=firstName%>" required></br> 
		Last Name: <input type="text" name="lastName" value="<%=lastNames%>" required></br> 
		Username: <input type="text" name="username" value="<%=username%>" required></br> 
		Password: <input type="text" name="password" value="<%=password%>" required></br>
		SSN: <input type="text" name="ssn" value="<%=ssn%>" required></br>
		Role: <select name="role" required>
			<option value="Customer"
				<%=role.equals("Customer") ? "selected" : ""%>>Customer</option>
			<option value="Representative"
				<%=role.equals("Representative") ? "selected" : ""%>>Representative</option>
			<option value="Administrator"
				<%=role.equals("Administrator") ? "selected" : ""%>>Administrator</option>
		</select></br> 
		<input type="hidden" name="accountNumber" value="<%=accountNumber%>">
		<input type="submit" value="Confirm">
	</form>




	<%
		}
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>


</body>
</html>