<%-- 
    Document   : logout
 
    Author     : Zainab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
%>
