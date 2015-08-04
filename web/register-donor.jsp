<%-- 
    Document   : register
  
    Author     : Zainab
--%>

<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Donor Sign Up</h1>
          </div>
        </div>
<%
        if(session.getAttribute("u_id") != null){
            response.sendRedirect("logged.jsp");
        }
        String error = "";
                    String email=request.getParameter("inputEmail");
                    String pass1=request.getParameter("inputPassword1");
                    String pass2=request.getParameter("inputPassword2");
                    String name=request.getParameter("inputName");
                    String fullname=request.getParameter("inputFullname");
                    String bday=request.getParameter("inputBirthday");
                    String sex = request.getParameter("inputSex");
                    String blood = request.getParameter("inputBlood");
                    String allergies = request.getParameter("inputAllergies");
                    String medications = request.getParameter("inputMedications");
                    String city = request.getParameter("inputCity");
                    String country = request.getParameter("inputCountry");
                    String contacts = request.getParameter("inputContacts");
                    
                    /*
                    
inputFullname/
inputName/
inputPassword/
inputPassword2/
inputEmail/
inputBirthday/
inputSex/
inputBlood/
inputAllergies
inputMedications
inputCity
inputCountry
inputContacts
                    
                    */

                    //different passwords
                    if(!(pass1==null && pass2==null) && pass1.compareTo(pass2)!=0){
                        error = error + "\nPasswords don't match";
                    }
                    
                    //taken username
                    String q = "select * from users where u_username = '" + name + "'";
                    try{
                         ResultSet rs=DB.getC().query(q);
                         if(rs.next()){
                             error+="<br>Username is not available";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    //taken email
                    q = "select * from users where u_email = '" + email + "'";
                    try{
                         ResultSet rs=DB.getC().query(q);
                         if(rs.next()){
                             error+="<br>This email is already associcated to an account";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(email==null && pass1==null && pass2==null && name==null){
                        error="";
                    }else if(error.length()==0){                        
                        q = "INSERT INTO `users`(`u_username`, `u_email`, `u_pass`, `u_type`, `u_birthday`, `u_sex`, `u_blood`, `u_name`, `u_country`, `u_city`, `u_contacts`, `u_allergies`, `u_medication`, `u_bloodqty`, `u_blooddate`) 	VALUES ( '"+name+"', '"+email+"', md5('"+pass1+"'), 1, '"+bday+"', "+sex+", '"+blood+"', '"+fullname+"', "+country+", '"+city+"', '"+contacts+"', '"+allergies+"', '"+medications+"', 0, now())";
                        try{
                             int rs=DB.getC().nonquery(q);
                             response.sendRedirect("login.jsp?ref=registration");
                        }catch(Exception e){
                            error = e.getMessage();
                        }
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
                    <legend>Sign up as a donor</legend>
                    <div class="form-group">
                      <label for="inputFullname" class="col-lg-2 control-label">Name</label>
                      <div class="col-lg-3">
                        <input class="form-control" id="inputFullname" name="inputFullname" placeholder="Your Name in Full" type="text" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputName" class="col-lg-2 control-label">Username</label>
                      <div class="col-lg-3">
                        <input class="form-control" id="inputName" name="inputName" placeholder="Username" type="text" minlength="4" maxlength="10" title="4,10 characters, alpha-numerics only" pattern="[0-9|a-z|A-Z]{4,10}" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword1" class="col-lg-2 control-label">Password</label>
                      <div class="col-lg-3">
                          <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword1" name="inputPassword1" placeholder="Password" type="password" type="text" minlength=6 maxlength=20 title="6 to 20 characters" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword2" class="col-lg-2 control-label">Re-type Password</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword2" name="inputPassword2" placeholder="Password Again" type="password" minlength=6 maxlength=20 title="6 to 20 characters" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center; cursor: auto;" class="form-control" id="inputEmail" name="inputEmail" placeholder="Email" type="email" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputBirthday" class="col-lg-2 control-label">Date of Birth</label>
                        <div class="controls col-lg-3">
                            <input name="inputBirthday" id="datepicker" type="text" class="form-control" maxlength="10" pattern="[0-9]{4}[-][0-9]{2}[-][0-9]{2}" title="2012-12-20 Format" required aria-required=”true”>
                       </div>
                    </div>

                    <div class="form-group">
                      <label for="inputSex" class="col-lg-2 control-label">Sex</label>
                      <div class="col-lg-3">
                        <select class="form-control" name="inputSex">
                            <option value="1">Male</option>
                            <option value="0">Female</option>
                        </select>
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
                                <option value="<%=s.toLowerCase()%>"><%=s%></option>
                                <%
                            }
                            %>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputAllergies" class="col-lg-2 control-label">Allergies if any</label>
                      <div class="col-lg-3">
                          <textarea rows=3 class="form-control" id="inputAllergies" name="inputAllergies"></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputMedications" class="col-lg-2 control-label">Any Medications on or have been taking in past 3 months</label>
                      <div class="col-lg-3">
                          <textarea rows=3 class="form-control" id="inputAllergies" name="inputMedications" required></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputCity" class="col-lg-2 control-label">City</label>
                      <div class="col-lg-3">
                        <input class="form-control" id="inputCity" name="inputCity" placeholder="City Name" type="text" required>
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
                                <option value="<%=Integer.toString(rs.getInt("id"))%>"><%=rs.getString("country_name")%></option>
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
                          <textarea rows=3 class="form-control" id="inputAllergies" name="inputContacts" required></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Register</button>
                      </div>
                    </div>
                  </fieldset>
                </form> 
<script type="text/javascript">
    $(function(){

        $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
    
    });

</script>
      
<jsp:include page="/WEB-INF/bottom.jsp"/>
