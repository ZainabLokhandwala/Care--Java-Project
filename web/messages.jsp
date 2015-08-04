<%-- 
    Document   : profile
  
    Author     : Zainab
--%>
<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
<%
if(session.getAttribute("u_id") == null){
   response.sendRedirect("login.jsp");
}

//bug String query = "SELECT distinct u_name,u_id FROM users where u_id in (select m_to from `inbox` WHERE inbox.m_to="+session.getAttribute("u_id").toString()+" or inbox.m_from="+session.getAttribute("u_id").toString()+" )";
String query = "SELECT distinct u_name,u_id FROM users,inbox where u_id=inbox.m_from and m_to= "+session.getAttribute("u_id").toString();
%>
<h1>Conversations</h1>

<table class="table table-striped table-hover ">
  <thead>
    <tr>
      <th>Name</th>
      <th>Profile</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
<%
    try{
        ResultSet msg = DB.getC().query(query);
        int count = 0;
        while (msg.next()){
            count++;
            %>
    <tr>
      <td><%=msg.getString("u_name")%></td>
      <td><a href="profile.jsp?u=<%=msg.getString("u_id")%>">View</a></td>
      <td><a href="msg.jsp?u=<%=msg.getString("u_id")%>#reply">Reply</a></td>
    </tr>
            <%
        }
        if(count==0){
            %>
    <tr>
      <td colspan="7">No Results</td>
    </tr>
            <%
        }
    }catch(Exception e){response.sendRedirect("error.jsp");}
            
%>
  </tbody>
</table>
    

<%

        
%>
<jsp:include page="/WEB-INF/bottom.jsp"/>
