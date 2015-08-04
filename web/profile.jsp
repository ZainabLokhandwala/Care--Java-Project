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
        
        String profile = session.getAttribute("u_id").toString();
        
        boolean me = true;
        if(request.getParameter("u")!=null){
            me=false;
            profile = request.getParameter("u");
        }
        String q = "SELECT  u_id, 	u_username, img_url,	u_email, 	u_type,year(now())-year(u_birthday) u_birthday,	u_sex,u_blood ,	u_name, 	u_city, 	u_contacts, 	u_allergies, 	u_medication, 	u_bloodqty, 	u_blooddate, 	country_name  FROM `users`,countries where u_country = countries.id and u_type<>0 and u_id="+profile;
        try{
            ResultSet user = DB.getC().query(q);
            if(user.next()){
%>
<div class="row" class="col-lg-3">
    <div style="text-align: center">
        
      <ul class="breadcrumb">
          <h1><%=user.getString("u_name")%></h1>
    <% if(user.getString("img_url").length()==0){ %>
    <img src="${pageContext.request.contextPath}/res/images/no-pic.jpg" width="200" />
    <% }else{ %>
    <img src="${pageContext.request.contextPath}/res/images/userphotos/<%=user.getString("img_url")%>" width="200" />
    <% } %>
    
          <h1><li><a href="#"><%=user.getString("u_blood").toUpperCase()%> <%=(user.getInt("u_type")==1?"Donor":"Receiver")%></a></li></h1>
          <li><a href="#"><%=Integer.toString(user.getInt("u_birthday"))%></a></li>
          <li><a href="#"><%=(user.getInt("u_sex")==1?"Male":"Female")%></a></li>
          <li><a href="#"><%=user.getString("country_name")%></a></li>
          <li><a href="#"><%=user.getString("u_city")%></a></li>
        </ul>
        
        <%if(user.getInt("u_type")==-1){//next blood receiving for reciever profile %>
        <div class="alert alert-dismissible alert-success">
            I need <strong><%=Integer.toString(user.getInt("u_bloodqty"))%> pints</strong> of blood on <%=user.getString("u_blooddate")%>.
        </div>
        <% } %>
        <div class="alert alert-dismissible alert-danger">
          <button type="button" class="close" data-dismiss="alert">×</button>
          <%if(me && user.getInt("u_type")==-1){%>
          <a href="upload.jsp" class="alert-link">Change Picture</a> | <a href="update-receiver.jsp" class="alert-link">Update Your Profile</a> | <a href="delete.jsp" class="alert-link">Delete account</a>
          <%}else if(me && user.getInt("u_type")==1){%>
          <a href="upload.jsp" class="alert-link">Change Picture</a> | <a href="update-donor.jsp" class="alert-link">Update Your Profile</a> | <a href="delete.jsp" class="alert-link">Delete account</a>
          <%}else{%>
          <a href="msg.jsp?u=<%=user.getString("u_id")%>#reply" class="alert-link">Send <%=user.getString("u_name")%> a Message</a>
          <%}%>
        </div>
        

      <div class="panel panel-warning">
        <div class="panel-heading">
          <h3 class="panel-title">My Allergies</h3>
        </div>
        <div class="panel-body">
          <%=user.getString("u_allergies")%>
        </div>
      </div>
      <%if(user.getInt("u_type")==1){//medications for donor %>
      <div class="panel panel-danger">
        <div class="panel-heading">
          <h3 class="panel-title">Medications on or have been taking in past 3 months</h3>
        </div>
        <div class="panel-body">
          <%=user.getString("u_medication")%>
        </div>
      </div> 
      <%}%>
      <div class="panel panel-info">
        <div class="panel-heading">
          <h3 class="panel-title">Contact Me</h3>
        </div>
        <div class="panel-body">
          <%=user.getString("u_contacts")%>
        </div>
      </div>
    </div>
</div>
<%
            }else{
                response.sendRedirect("error.jsp");
            }
        }catch(Exception e){
            response.sendRedirect("error.jsp");
        }
        
        
%>
<jsp:include page="/WEB-INF/bottom.jsp"/>
