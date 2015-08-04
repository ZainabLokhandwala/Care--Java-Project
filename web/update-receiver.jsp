<%-- 
    Document   : register
 
    Author     : Zainab
--%>

<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Your Receiver Profile</h1>
          </div>
        </div>
<%
        if(session.getAttribute("u_id") == null){
            response.sendRedirect("login.jsp");
        }
        if(session.getAttribute("u_type").toString().equals("1")){
            response.sendRedirect("update-donor.jsp");
        }
        String update = "";
        String error = "";
                    String email=request.getParameter("inputEmail");
                    String fullname=request.getParameter("inputFullname");
                    String bday=request.getParameter("inputBirthday");
                    String sex = request.getParameter("inputSex");
                    String blood = request.getParameter("inputBlood");
                    String allergies = request.getParameter("inputAllergies");
                    String city = request.getParameter("inputCity");
                    String country = request.getParameter("inputCountry");
                    String contacts = request.getParameter("inputContacts");
                    String qty = request.getParameter("inputQuantity");
                    String nextday = request.getParameter("inputNextday");
                    String q="";

                    //taken email
                    q = "select * from users where u_email = '" + email + "' and u_id<>"+session.getAttribute("u_id").toString();
                    try{
                         ResultSet rs=DB.getC().query(q);
                         if(rs.next()){
                             error+="<br>This email is already associcated to an account";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(email==null && fullname==null){
                        error=""; //first load
                    }else if(error.length()==0){                        
                        q = "UPDATE `users` set `u_email`='"+email+"', `u_birthday`='"+bday+"', `u_blood`='"+blood+"', `u_name`='"+fullname+"', `u_country`="+country+", `u_city`='"+city+"', `u_contacts`='"+contacts+"', `u_allergies`='"+allergies+"', `u_bloodqty`="+qty+", `u_blooddate`='"+nextday+"' where u_id="+session.getAttribute("u_id").toString();
                        try{
                             int rs=DB.getC().nonquery(q);
                             update="Profile Update Succesfull";
                             //response.sendRedirect("update-donor.jsp");
                             
                        }catch(Exception e){
                            error = e.getMessage();
                        }
                    }
                    
%> 
<% if(update.length()>0){
%>
<div class="alert alert-dismissible alert-success">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Success!</h4>
  <p><%=update%></p>
</div>
<%
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
<%
try{
    ResultSet user = DB.getC().query("select * from users,countries where u_country=countries.id and u_id="+session.getAttribute("u_id").toString());
    if(user.next()){
        %>
<form class="form-horizontal" method="POST">
                  <fieldset>
                    <legend>Exsisting Data</legend>
                    <div class="form-group">
                      <label for="inputFullname" class="col-lg-2 control-label" >Name</label>
                      <div class="col-lg-3">
                        <input class="form-control" value="<%=user.getString("u_name")%>" id="inputFullname" name="inputFullname" placeholder="Your Name in Full" type="text" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                      <div class="col-lg-3">
                        <input value="<%=user.getString("u_email")%>" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center; cursor: auto;" class="form-control" id="inputEmail" name="inputEmail" placeholder="Email" type="email" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputBirthday" class="col-lg-2 control-label">Date of Birth</label>
                        <div class="controls col-lg-3">
                            <input value="<%=user.getString("u_birthday")%>" name="inputBirthday" id="datepicker" type="text" class="form-control" maxlength="10" pattern="[0-9]{4}[-][0-9]{2}[-][0-9]{2}" title="2012-12-20 Format" required aria-required=”true”>
                       </div>
                    </div>
                    <div class="form-group">
                      <label for="inputBlood" class="col-lg-2 control-label">Blood Group</label>
                      <div class="col-lg-3">
                        <select class="form-control" name="inputBlood">
                            <%

                            String[] bloodGroups = {    "A", "A+","A-",
                                                        "B", "B+","B-",
                                                        "AB", "AB+","AB-",
                                                        "O", "O+","O-"};

                            for (String s: bloodGroups) {           
                                %>
                                <option value="<%=s.toLowerCase()%>" <%=(s.toLowerCase().equals(user.getString("u_blood")))?"selected":""%>><%=s%></option>
                                <%
                            }
                            %>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputAllergies" class="col-lg-2 control-label">Allergies if any</label>
                      <div class="col-lg-3">
                          <textarea rows=3 class="form-control" id="inputAllergies" name="inputAllergies"><%=user.getString("u_allergies")%></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputQuantity" class="col-lg-2 control-label">Quantity of blood required</label>
                        <div class="col-lg-3">
                            <span class="input-group-addon">Pints</span>
                            <input value="<%=Integer.toString(user.getInt("u_bloodqty"))%>" class="form-control" type="text" name="inputQuantity" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" required>
                        </div>
                    </div>
                    <div class="form-group">
                      <label for="inputNextday" class="col-lg-2 control-label">Date when blood is required</label>
                        <div class="controls col-lg-3">
                            <input value="<%=user.getString("u_blooddate")%>" name="inputNextday" id="datepicker2" type="text" class="form-control" readonly maxlength="10" pattern="[0-9]{4}[-][0-9]{2}[-][0-9]{2}" title="2012-12-20 Format" required aria-required=”true”>
                       </div>
                    </div>
                    <div class="form-group">
                      <label for="inputCity" class="col-lg-2 control-label">City</label>
                      <div class="col-lg-3">
                        <input value="<%=user.getString("u_city")%>" class="form-control" id="inputCity" name="inputCity" placeholder="City Name" type="text" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputCountry" class="col-lg-2 control-label">Country</label>
                      <div class="col-lg-3">
                        <select class="form-control" name="inputCountry">
                            <%
                            try{
                                 ResultSet rs=DB.getC().query("select id,country_name from countries order by id asc");
                                 while(rs.next()){
                                %>
                                <option value="<%=Integer.toString(rs.getInt("id"))%>" <%=(rs.getInt("id")==user.getInt("id"))?"selected>":">"%><%=rs.getString("country_name")%></option>
                                <%
                                 }
                            }catch(Exception e){

                            }
                            %>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputContacts" class="col-lg-2 control-label">Contact Details</label>
                      <div class="col-lg-3">
                          <textarea rows=3 class="form-control" id="inputAllergies" name="inputContacts" required><%=user.getString("u_contacts")%></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Update</button>
                      </div>
                    </div>
                  </fieldset>
                </form> 
        <%
    }
}catch(Exception e){
    
}
%>
                
<script type="text/javascript">
    $(function(){

        $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
        $( "#datepicker2" ).datepicker({ dateFormat: 'yy-mm-dd' });
    });

</script>
      
<jsp:include page="/WEB-INF/bottom.jsp"/>
