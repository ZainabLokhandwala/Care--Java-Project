<%-- 
   
    Author     : Zainab
--%>

<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
<%
    //avoid non logged in members
        if(session.getAttribute("u_id") == null){
            response.sendRedirect("login.jsp");
        }
    //check for actions
        if(request.getParameter("confirm") != null && request.getParameter("confirm").toString().equalsIgnoreCase("yes") ){
            //go ahead and delete
            try{
                String q = "DELETE FROM USERS where u_id = "+ session.getAttribute("u_id").toString() ;
                int a = DB.getC().nonquery(q);
                if(a==1){
                    //success
                    response.sendRedirect("logout.jsp");
                }else{
                    //someone has tried to hack to the system
                    response.sendRedirect("error.jsp");
                }
            }catch(Exception ex){
                response.sendRedirect("error.jsp");
            }
        }
        
%>

<h1>Delete Profile?</h1>
<div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title">Profile Deletion</h3>
  </div>
  <div class="panel-body">
    Do you really want to delete? This action is irreversible
  </div>
    <div class="panel-footer">
        <a href="profile.jsp" class="btn btn-success">Nope, Cancel</a>
        <a href="delete.jsp?confirm=yes" class="btn btn-danger">Yes, Delete</a>
    </div>
</div>
<jsp:include page="/WEB-INF/bottom.jsp"/>