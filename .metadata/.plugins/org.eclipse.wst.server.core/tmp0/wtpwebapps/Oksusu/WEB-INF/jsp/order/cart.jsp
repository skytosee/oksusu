<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
	<script src="<c:url value='/js/hero.js'/>"></script>
</head>
<body>
    <!-- 품목 리스트 -->
    <div>
    <br/>
    <c:choose>
	    <c:when test="${fn:length(list) > 0}">
	         <c:forEach items="${list}" var="row" varStatus="status">
	             <div class="row">
	                <div class="col-md-3">
			          <c:choose>
	                  <c:when test="${row.STORED_IMG_NAME ne ''}">
	                 	<img class="img-rounded" src="<c:url value='/files/${row.STORED_IMG_NAME}' />" alt="${row.ITEM_NM }" width="200" height="150">
	                  </c:when>
	                  <c:otherwise>
	                 	<img class="img-rounded" src="<c:url value='/images/item/NoImage.png' />" alt="${row.ITEM_NM }" width="200" height="150">
	                  </c:otherwise>
	                  </c:choose>
			        </div>
			        <div class="col-md-6">
			          <h2>${row.ITEM_NM }</h2>
			          <p>${row.ITEM_DC }</p>
			        </div>
			        <div class="col-md-3">
			          <form class="form-horizontal">
			            <div class="has-success">
						  <div class="checkbox">
						    <label>
						      <input type="checkbox" id="check_${row.ITEM_CD}" value="" checked="${row.CHECK_YN}">
						      주문선택 
						    </label>
						  </div>
						</div>		          	
                     	<label for="um_${row.ITEM_CD}" class="col-sm-3 control-label">가격</label>
					    <div class="col-sm-9">
					      <input type="number" class="form-control" id="um_${row.ITEM_CD}" value="${row.PRICE}" readonly >
					    </div>					
                      	<label for="qt_${row.ITEM_CD}" class="col-sm-3 control-label">수량</label>
					    <div class="col-sm-9">
					      <input type="number" class="form-control" id="qt_${row.ITEM_CD}" value="${row.ITEM_QT}" onchange="qtChange(this);" >
					    </div>
                      	<label for="am_${row.ITEM_CD}" class="col-sm-3 control-label">금액</label>
					    <div class="col-sm-9">
					      <input type="number" class="form-control" id="am_${row.ITEM_CD}" value="${row.ITEM_AM}" readonly >
					    </div>
					    <div>
					      <input type="hidden" class="form-control" id="nm_${row.ITEM_CD}" value="${row.ITEM_NM}">      
					      <input type="hidden" class="form-control" id="dc_${row.ITEM_CD}" value="${row.ITEM_DC}">  
					    </div>       
			          </form>
			        </div>
			     </div>  
			     <hr/>   
	         </c:forEach>
		</c:when>
	</c:choose>
    <div style="text-align: center;">
    	<button type="button" id="btnOrder" class="btn btn-warning">주문하기</button>
  		<button type="button" id="btnDelete" class="btn btn-default">선택삭제</button>
    </div>
  </div>
  
  <script type="text/javascript">
  $(document).ready(function(){ 
	  // 주문 버튼
	  $('#btnOrder').click(function() {
		  var order = new Array();
		  var strIndex = "check_".length;
		
		  $(':checkbox').each(function(index, element) {
			  if ($(this)[0].checked) {
				  var id = $(this)[0].id.substring(strIndex); 
	    		  var ietm = new Object();
	    		  ietm.ITEM_CD = id;
	    		  ietm.ITEM_NM = $('#nm_' + id).val();
	    		  ietm.ITEM_DC = $('#dc_' + id).val();
	    		  ietm.PRICE = $('#um_' + id).val();
	    		  ietm.ITEM_QT = $('#qt_' + id).val();
	    		  ietm.ITEM_AM = $('#am_' + id).val();       
	    		  order.push(ietm);  
			  }
		  });
		  
		  postToUrl('/order/list.do', {'list': JSON.stringify(order)});
	  });
	  
	  // 삭제 버튼
	  $('#btnDelete').click(function() {
		  var strIndex = "check_".length;
		  var ids = "";
		  $(':checkbox').each(function(index, element) {	  
			  if ($(this)[0].checked) {
				  var id = $(this)[0].id.substring(strIndex); 
				  ids += id + "|";
			  }
		  });
		  saveCart(ids);
	  });
  });
  
  // 수량 변경
  function qtChange(input){
	var strIndex = "qt_".length;
	var id = input.id.substring(strIndex); 
  	var um = $('#um_' + id).val();
  	var qt = $('#qt_' + id).val();
  	var am = Number(um) * Number(qt);
  	$('#am_' + id).val(am);
  }
  
  function saveCart(id) {
	 $.ajax({
	        url: '/order/cartSave.do',
	        type: "POST",
	        dataType: 'json',
	        data: { "dml_fg":"D", "id": id },
	        async: false,
	        cache: false,
	        success: function(data) {
	        	location.href = data.redirect;
		    },
	        error:function(request,status,error){
	        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
	 });
  } 
  
  //post 전송
  function postToUrl(path, params, method) {
      method = method || "post";  //method 부분은 입력안하면 자동으로 post가 된다.
      var form = document.createElement("form");
      form.setAttribute("method", method);
      form.setAttribute("action", path);
      //input type hidden name(key) value(params[key]);
      for(var key in params) {
          var hiddenField = document.createElement("input");
          hiddenField.setAttribute("type", "hidden");
          hiddenField.setAttribute("name", key);
          hiddenField.setAttribute("value", params[key]);
          form.appendChild(hiddenField);
      }
      document.body.appendChild(form);
      form.submit();
  }

  </script>
</body>
</html>
