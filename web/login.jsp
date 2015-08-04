<%-- 
    Document   : login
 
    Author     : Zainab
--%>

<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>

<%

    if(request.getParameter("ref")!=null && request.getParameter("ref").equalsIgnoreCase("registration")){
        %>
<div class="alert alert-dismissible alert-success">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Welcome!</h4>
  <p>Thank you for registering, please login</p>
</div>
        <%
    }
    
%>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Login</h1>
          </div>
        </div>
<%
        if(session.getAttribute("u_id") != null){
            response.sendRedirect("logged.jsp");
        }
                    String user=request.getParameter("inputEmail");
                    String pass=request.getParameter("inputPassword");
                    String error = "";
                    if(pass!=null){
                        pass = DB.getC().SQLSafe(pass);
                    }
                    String q = "select * from users where (u_email = '" + user + "' or u_username = '" + user + "') and u_pass = md5('" + pass +"')";
                    try{
                         ResultSet rs=DB.getC().query(q);
                         if(rs.next()){
                            session = request.getSession();
                            session.setAttribute("u_id", Integer.toString(rs.getInt("u_id")));
                            session.setAttribute("u_username", rs.getString("u_username"));
                            session.setAttribute("u_name", rs.getString("u_name"));
                            //0 admin -1 receiver +1 donor
                            session.setAttribute("u_type", Integer.toString(rs.getInt("u_type")));
                            session.setAttribute("u_pass", rs.getString("u_pass"));
                            session.setMaxInactiveInterval(30*60);
                            response.sendRedirect("index.jsp");
                         }else{
                             error = "Invalid Combination";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(user==null && pass==null){
                        error="";
                    }
                    
%> 
<% if(error.length()>0){
%>
<div class="alert alert-dismissible alert-warning">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Error!</h4>
  <p><%=error%></p>
</div>
<%
}
%>

                <form class="form-horizontal" method="POST">
                  <fieldset>
                    <legend>Login to your account</legend>
                    <div class="form-group">
                      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center; cursor: auto;" class="form-control" id="inputEmail" name="inputEmail" placeholder="Email or Username" type="text" minlength="4" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword" class="col-lg-2 control-label">Password</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword" name="inputPassword" placeholder="Password" type="password" required>
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Login</button>
                      </div>
                    </div>
                    <div class="form-group" style="display:none">
                      <div class="col-lg-5">
                            <div class="panel panel-info">
                              <div class="panel-heading">
                                <h3 class="panel-title">Forgot your password?</h3>
                              </div>
                              <div class="panel-body">
                                <a class="form-control" href="${pageContext.request.contextPath}/forgot.jsp">Click Here To Reset</a>
                              </div>
                            </div>
                          
                      </div>
                    </div>
                  </fieldset>
                </form>
            
      
<jsp:include page="/WEB-INF/bottom.jsp"/>
