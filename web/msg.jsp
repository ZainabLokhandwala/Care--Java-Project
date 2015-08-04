<%-- 
    Document   : msg
   
    Author     : Zainab
--%>

<%@page import="org.apache.commons.mail.DefaultAuthenticator"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="org.apache.commons.mail.Email"%>
<%@page import="java.sql.*,zainab.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
<br><Br>
<%
        if(session.getAttribute("u_id") == null){
            response.sendRedirect("login.jsp");
        }
        if(request.getParameter("u") == null){
            response.sendRedirect("error.jsp");
        }
        
        try{
            String q = "select * from users where u_id="+request.getParameter("u").toString();
            ResultSet rs=DB.getC().query(q);{
                if(rs.next()){
                    //valid user
                    //send current message
                    String newmsg = request.getParameter("textArea");
                    if(newmsg==null){
                        
                    }else{
                        
                        //update database first
                        try{
                            String newms = "INSERT INTO `inbox`(`m_from`, `m_to`, `m_content`) VALUES ("+session.getAttribute("u_id").toString()+", "+request.getParameter("u").toString()+", '"+DB.getC().SQLSafe(newmsg)+"')";
                            DB.getC().nonquery(newms);
                            String server =  "http://"+request.getServerName() +":"+ request.getServerPort() + request.getContextPath();
                            String msgBody = "Message :\n\n"+ newmsg+", \n\nVisit this link to reply : ";
                            msgBody+=server+"/msg.jsp?u="+request.getParameter("u").toString();
                            msgBody+= "\nCare - Share a little, Care a little\n\n";
                            Email email = new SimpleEmail();
                            email.setHostName("mail.virtualrival.com");
                            email.setSmtpPort(25);
                            email.setAuthenticator(new DefaultAuthenticator("zainab@virtualrival.com", "C0654437"));
                            email.setSSLOnConnect(true);
                            email.setFrom("no-reply@zainab.com");
                            email.setSubject("CARE : New Message From "+rs.getString("u_name"));
                            email.setMsg(msgBody);
                            email.addTo(rs.getString("u_email"));
                            email.send();
                        }catch(Exception ex){
                            out.print(ex.getMessage());
                        }
                            
                    }
                    //load conversation
                    %>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1><%=rs.getString("u_name")%> : Messages</h1>
          </div>
        </div>
                    <%
                    String m = "SELECT m_date,m_from,m_seen,m_content FROM `inbox` where ((m_from="+session.getAttribute("u_id").toString()+" and m_to="+request.getParameter("u").toString()+") OR (m_from="+request.getParameter("u").toString()+" and m_to="+session.getAttribute("u_id").toString()+")) order by m_date asc";
                    String m_read = "UPDATE inbox set m_seen=1 where m_from="+request.getParameter("u").toString()+" and m_to="+session.getAttribute("u_id").toString();
                    try{
                        ResultSet msg=DB.getC().query(m);
                        while(msg.next()){
                            if(msg.getInt("m_from")==Integer.valueOf(session.getAttribute("u_id").toString())){
                                //light
                                %>
<div class="panel panel-conetnt">
  <div class="panel-heading">
    <h3 class="panel-title">Me on <%=msg.getString("m_date")%></h3>
  </div>
  <div class="panel-body">
    <%=msg.getString("m_content")%>
  </div>
  <div class="panel-footer"><%=(msg.getInt("m_seen")==1)?"Message Seen":"Not Seen Yet"%></div>
</div>
                                <%
                            }else{
                                //dark
                                %>
<div class="panel panel-primary">
  <div class="panel-heading">
      <h3 class="panel-title"><a href="profile.jsp?u=<%=Integer.toString(rs.getInt("u_id"))%>"><%=rs.getString("u_name")%></a> on <%=msg.getString("m_date")%></h3>
  </div>
  <div class="panel-body">
    <%=msg.getString("m_content")%>
  </div>
  <div class="panel-footer"><%=(msg.getInt("m_seen")==1)?"Old Message":"New Message"%></div>
</div>
                                <%
                            }
                        }
                        DB.getC().nonquery(m_read);
                    }catch(Exception ex){
                        out.print("Error Fetching Messages" + ex.getMessage());
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }
            }
        }catch(Exception e){
            response.sendRedirect("error.jsp");
        }
        
        
%>

<form class="form-horizontal" id="reply" method="POST">
  <fieldset>
    <legend>Compose a new message</legend>
    <div class="form-group">
      <label for="textArea" class="col-lg-2 control-label">Your Message</label>
      <div class="col-lg-10">
        <textarea name="textArea" class="form-control" rows="3" id="textArea" required></textarea>
        <span class="help-block">Recipient will be notified by email too</span>
      </div>
    </div>
    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <button type="reset" class="btn btn-default">Clear</button>
        <button type="submit" class="btn btn-primary">Send</button>
      </div>
    </div>
  </fieldset>
</form>
<jsp:include page="/WEB-INF/bottom.jsp"/>