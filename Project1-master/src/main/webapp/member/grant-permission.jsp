<%@ page import="Spring.MemberDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
String targetUsername = request.getParameter("username");
String newPermission = request.getParameter("permission");

MemberDAO memberMgr = new MemberDAO();
boolean success = memberMgr.changePermission(targetUsername, newPermission);

if (success) {
    response.sendRedirect("admin.jsp?grantSuccess=true");
} else {
    response.sendRedirect("admin.jsp?grantSuccess=false");
}
%>
