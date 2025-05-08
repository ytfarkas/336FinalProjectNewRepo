<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in
</br>

<%
} else if (session.getAttribute("role").equals("Customer")) {
response.sendRedirect("customerHome.jsp");
} else if (session.getAttribute("role").equals("Representative")) {
response.sendRedirect("repHome.jsp");

} else if (session.getAttribute("role").equals("Administrator")) {
response.sendRedirect("adminHome.jsp");

}
%>

