<%-- 
    Document   : logout
    Created on : Apr 14, 2025, 10:47:31 PM
    Author     : MyBook14F
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    </head>
 <%
    session.invalidate();
    response.sendRedirect("index.html");
%>

</html>
