<%-- 
    Author     : zainab
--%>
<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Care - Share a little, Care a little</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/res/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/res/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/jquery.dataTables.css"> 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/santiago.datepicker.css"> 
    <link rel="stylesheet" type="text/css" media="all"
      href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/smoothness/jquery-ui.css"    />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/res/jquery.dataTables.js"></script>
  </head>
  <body>
    <div class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a href="${pageContext.request.contextPath}" class="navbar-brand">CARE</a>
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
<%
        session = request.getSession(false);
        if(session.getAttribute("u_id") != null){ //logged in menu
            int new_count=0;
            String q="select count(*) from inbox where m_seen=0 and m_to="+session.getAttribute("u_id").toString();
        try{
                ResultSet rs=DB.getC().query(q);
                if(rs.next()){
                    new_count=rs.getInt(1);
                }
                }catch(Exception e){
                    new_count = -1;
                }
%>

        <div class="navbar-collapse collapse" id="navbar-main">

          <ul class="nav navbar-nav">
              <li><a href="${pageContext.request.contextPath}/search.jsp">
            <%
            try{
                String usercount="select count(*) from users where u_type=";
                if(session.getAttribute("u_type").toString().equalsIgnoreCase("1")){
                    //receiver
                    usercount+="-1";
                    %>
                    Receivers <span class="badge">
                    <%
                }else{
                    usercount+="1";
                    %>
                    Donors <span class="badge">
                    <%
                }
                ResultSet rs = DB.getC().query(usercount);
                if(rs.next()){
                    out.print(Integer.toString(rs.getInt(1)));
                }
            }
            catch(Exception e){
                
            }
            %>
            </span></a></li>
            <li><a href="${pageContext.request.contextPath}/profile.jsp"><span class="badge"><%=session.getAttribute("u_name")%></span></a></li>
            <li><a href="${pageContext.request.contextPath}/messages.jsp">Inbox <span class="badge"><%=new_count%></span></a></li>
          </ul>

          <ul class="nav navbar-nav navbar-right">
            <li>
                <p class="navbar-btn">
                    <a href="${pageContext.request.contextPath}/logout.jsp" class="btn btn-danger" style="margin-left: 5px">Logout</a>
                </p>
            </li>
          </ul>

        </div>

<%
        }else{
%>
        <div class="navbar-collapse collapse" id="navbar-main">
          <ul class="nav navbar-nav navbar-right">
            <li>
                <p class="navbar-btn">
                    <a onClick="javascript:showReg();" class="btn btn-success">Create an account</a>
                    <!--a href="${pageContext.request.contextPath}/register-donor.jsp" class="btn btn-success">Create an account D</a>
                    <a href="${pageContext.request.contextPath}/register-receiver.jsp" class="btn btn-success">Create an account R</a-->
                </p>
            </li>
            <li>
                <p class="navbar-btn">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-warning" style="margin-left: 5px">Sign in</a>
                </p>
            </li>
          </ul>

        </div>
<% } %>
        
      </div>

    </div>

<br><br>
    <div class="container">
