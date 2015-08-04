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
boolean imadonor=true;
if(session.getAttribute("u_type").toString().equalsIgnoreCase("-1")){
    imadonor=false;
}

String city = request.getParameter("city");
String blood = request.getParameter("blood");
String country = request.getParameter("country");

boolean s_city = false;
boolean s_blood = false;
boolean s_country = false;

String query = "SELECT  u_id, 	u_username, 	u_email, 	u_type,year(now())-year(u_birthday) u_birthday,	u_sex,u_blood ,	u_name, 	u_city, 	u_contacts, 	u_allergies, 	u_medication, 	u_bloodqty, 	u_blooddate, 	country_name  FROM `users`,countries where u_country = countries.id and u_type<>0 ";
if(imadonor){
    query += " and u_type = -1 ";
}else{
    query += " and u_type = 1 ";
}
if(city==null){
    /*
    }*/
}else{
    if(city.trim().compareTo("")!=0){
        s_city = true;
        query += " and u_city like '%"+DB.getC().SQLSafe(city)+"%' ";
    }
}
if(blood==null){

}else{
    if(blood.trim().compareTo("all")!=0){
        s_blood = true;
        query += " and u_blood = '"+blood+"' ";
    }
}/*
if(country==null){
    
}else{
    if(country.trim().compareTo("any country")!=0){
        s_country = true;
        query += " and countries.id = "+country+" ";
    }
}*/
%>
<h1>Search for <%=((imadonor)?"Receivers":"Donors")%></h1>
<form class="form-horizontal" method="POST">
  <fieldset>

    <div class="form-group">
    
      <div class="col-lg-2">
      <input class="form-control" name="city" placeholder="City" type="text">
      </div>
    
      <div class="col-lg-1">
        <select class="form-control" name="blood">
            <option value="all" selected>all</option>
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
<!--div class="col-lg-3">
        <select class="form-control" name="country">
            <option value="all" selected>any country</option>
            <%
            try{
                 ResultSet rs=DB.getC().query("select id,country_name from countries order by id asc");
                 while(rs.next()){
                %>
                <option value="<%=Integer.toString(rs.getInt("id"))%>"><%=rs.getString("country_name")%></option>
                <%
                 }
            }catch(Exception e){
                response.sendRedirect("error.jsp");
            }
            %>
        </select>
      </div-->
      <div class="col-lg-1">
        <button type="submit" class="btn btn-primary">Search</button>
      </div>
    </div>
  </fieldset>
</form>
<table class="table table-striped table-hover ">
  <thead>
    <tr>
      <th>Blood Type</th>
      <th>Name</th>
      <th>Age</th>
      <th>Sex</th>
      <th>City</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
<%
    try{
        ResultSet user = DB.getC().query(query);
        int count = 0;
        while (user.next()){
            count++;
            %>
    <tr>
      <td><%=user.getString("u_blood").toUpperCase()%></td>
      <td><a href="profile.jsp?u=<%=user.getString("u_id")%>"><%=user.getString("u_name")%></a></td>
      <td><%=Integer.toString(user.getInt("u_birthday"))%></td>
      <td><%=(user.getInt("u_sex")==1?"Male":"Female")%></td>
      <td><%=user.getString("u_city")%></td>
      <td><%=user.getString("country_name")%></td>
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
