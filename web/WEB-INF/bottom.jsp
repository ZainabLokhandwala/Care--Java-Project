<%-- 
    Author     : Zainab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
function showReg(){
    $('.modal').show();
    $('.modal-dialog').css({ "width": '290px'});
    $('.modal').css({ "background-color":'#BF3E11'});
}
function showDel(){
    $('.modal').show();
    $('.modal-dialog').css({ "width": '290px'});
    $('.modal').css({ "background-color":'#BF3E11'});
}
</script>
      <div class="modal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title">Hello there!</h1>
            </div>
            <div class="modal-body">
              <h2>Choose Your Role</h2>
              <a href="${pageContext.request.contextPath}/register-donor.jsp" class="btn btn-success btn-lg">DONOR +</a>
              <a href="${pageContext.request.contextPath}/register-receiver.jsp" class="btn btn-warning btn-lg">RECEIVER -</a>
            </div>
          </div>
        </div>
      </div>
      <footer>
            <div class="row">
                <p><a href="#top">&uarr; Top</a> | <a href="#" target=_blank>GitHub</a> | By <a href="https://www.facebook.com/zainab.lokhandwala.35" target=_blank>Zainab Lokhandwala</a> [C0654437]</p>
            </div>
      </footer>
    </div>
    <script src="${pageContext.request.contextPath}/res/bootstrap.min.js" />
</body>
</html>
