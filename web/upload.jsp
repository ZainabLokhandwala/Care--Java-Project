<%-- 
    Document   : upload
 
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
            
        String image = "";
        try{
            ResultSet rs = DB.getC().query("select img_url from users where u_id="+session.getAttribute("u_id").toString());
            if(rs.next()){
                image = rs.getString("img_url");
            }
        }   catch(Exception e){
            response.sendRedirect("error.jsp");
        } 

        
%>

<h1>Profile Photo</h1>
<form class="form-horizontal" method="POST" enctype="multipart/form-data" action="upload">
                  <fieldset>
                    <legend>Profile Picture</legend>
                    <div id="disp_tmp_path"></div>
                    <br>
                    <% if(image.length()==0){ %>
                    <img src="${pageContext.request.contextPath}/res/images/no-pic.jpg" width="200" />
                    <% }else{ %>
                    <img src="${pageContext.request.contextPath}/res/images/userphotos/<%=image%>" width="200" />
                    <% } %>
                    <br>
                    <div id="imageError" style="display:none" class="alert alert-dismissible alert-danger">
                      <button type="button" class="close" data-dismiss="alert">×</button>
                      <strong>Error!</strong> Valid images only
                    </div>
                    <input type="file" id="inputImage" name="inputImage" value="" />
                    <br>
                    <input type="hidden" id="tempURL" />
                    <div class="form-group">
                      <div class="col-lg-5 ">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button id="send_btn" type="submit" class="btn btn-primary" onclick="return validateImage()">Upload</button>
                      </div>
                    </div>
                  </fieldset>
                </form>
<jsp:include page="/WEB-INF/bottom.jsp"/>
