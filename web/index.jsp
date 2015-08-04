<%-- 
 
    Author     : Zainab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/top.jsp"/>
<div class="page-header" id="banner">
    <div class="row">

      <div class="col-lg-4 col-md-5 col-sm-6">
        <div class="sponsor">
            <img src="${pageContext.request.contextPath}/res/images/bg-home.png">
        </div>
      </div>
      <div class="col-lg-8 col-md-7 col-sm-6">
        <h1>Welcome To Care</h1>
        <p class="lead">An online blood donation portal!</p>
        <blockquote>
          <p>This is a web application, which aims at connecting blood donors and receivers on a single platform just at the click of a finger. We all know emergencies can happen anytime and someone would be in eager need of blood, and CARE is the best platform for a donor to reach a receiver at this time of emergency or vice versa.</p>
          <small>Zainab</small>
          
        </blockquote>
        <p><a href="tel:+15193129719" class="btn btn-primary btn-lg">Call Us Now!</a></p>
      </div>
    </div>
  </div>
<div class="progress progress-striped active">
  <div class="progress-bar" style="width: 100%"></div>
</div>
<div class="row">
    <div class="jumbotron">
        <h1>Donate blood today &amp; be a <strong>HERO</strong>!!</h1>
    </div>
</div>
<jsp:include page="/WEB-INF/bottom.jsp"/>
