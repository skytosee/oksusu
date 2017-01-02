<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
	<script src="<c:url value='/js/hero.js'/>"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
    <!-- 품목 리스트 -->
    <div>
    <br/>
    <c:choose>
	    <c:when test="${fn:length(list) > 0}">
	         <c:forEach items="${list}" var="row" varStatus="status">
	             <div class="row"> 
			        <div class="col-md-2">
			          <p><b>${row.ITEM_NM}</b></p>
			        </div>
			        <div class="col-md-4">
			          <p>${row.ITEM_DC}</p>
			        </div>
			        <div class="col-md-2">           	          	
                     	<label for="um_${row.ITEM_CD}" class="col-sm-4 control-label">가격</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" id="um_${row.ITEM_CD}" value="${row.PRICE}" style="text-align: right;" readonly >
					    </div>	
					</div>    	
					<div class="col-md-2">  			
                      	<label for="qt_${row.ITEM_CD}" class="col-sm-4 control-label">수량</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" id="qt_${row.ITEM_CD}" value="${row.ITEM_QT}" style="text-align: right;" onchange="qtChange(this);" >
					    </div>
					</div>  
					<div class="col-md-2">    
                      	<label for="am_${row.ITEM_CD}" class="col-sm-4 control-label">금액</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" id="am_${row.ITEM_CD}" value="${row.ITEM_AM}" style="text-align: right;" readonly >
					    </div> 
			        </div>
			        <div>
		  				<input type="hidden" class="form-control" id="nm_${row.ITEM_CD}" value="${row.ITEM_NM}">      
		    		</div>
			     </div>  
			     <hr/>   
	         </c:forEach>
		</c:when>
	</c:choose>
	<div class="row"> 
		<div class="col-md-8">
		</div>
		<div class="col-md-4">
          <form class="form-horizontal">              	
            <label for="sum_am" class="col-sm-3 control-label">총금액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="sum_am" style="color:blue; text-align: right;" readonly >
		    </div>					
            <label for="sum_vat" class="col-sm-3 control-label">부가세</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="sum_vat" style="text-align: right;" readonly >
		    </div>
            <label for="sum_pay" class="col-sm-3 control-label">결제금액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="sum_pay" style="color:red; text-align: right;" readonly >
		    </div>    
		    <div>
		      <input type="hidden" class="form-control" id="sum_cd" value=""> 
		      <input type="hidden" class="form-control" id="sum_nm" value=""> 
		      <input type="hidden" class="form-control" id="sum_qt" value=""> 	      
		    </div>
          </form>
    	</div>
	</div>
	<hr/>
	<div>
	  <h2>배송정보</h2>
	  <form class="form-horizontal" method="post" action="accountProcess.do" id="accountForm" data-parsley-validate="">
	  <div class="row"> 
		  <div class="form-group">
		    <label for="inputName" class="col-sm-1 control-label">이름</label>
		    <div class="col-sm-2">
		      <input name="userName" class="form-control" id="inputName" placeholder="Name" value="${user.userName}">
		    </div>
		    <label for="inputPhone" class="col-sm-1 control-label">연락처</label>
		    <div class="col-sm-2">
		      <input name="phone" type="number" class="form-control" id="inputPhone" placeholder="Phone" value="${user.phone}">
		    </div>
		  </div>
	  </div>
	  <div class="row"> 
	  	<div class="form-group">
		    <label for="inputZip" class="col-sm-1 control-label">우편번호</label>
		    <div class="col-sm-2">
		      <input name="zip" type="number" class="form-control" id="inputZip" placeholder="zip" value="${user.zip}">
		    </div>
		    <button class="btn btn-success" id="btn_zip">주소찾기</button>
	  	</div>
	  </div>
	  <div class="row"> 
		  <div class="form-group">
		    <label for="inputAddr" class="col-sm-1 control-label">주소</label>
		    <div class="col-sm-10">
		      <input name="address" class="form-control" id="inputAddr" placeholder="address" value="${user.address}">
		    </div>
		  </div>
	  </div>
	  </form>
	  <input type="hidden" id="user_id" value="${user.userId}">      
	</div>
	<hr/>
    <div style="text-align: center;">
    	<button type="button" id="btnOrder" class="btn btn-primary">결제하기</button>
  		<button type="button" id="btnCancel" class="btn btn-default">주문취소</button>
    </div>
  </div>
  <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
  <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
  </div>
  
  <script type="text/javascript">
  // 우편번호 찾기 화면을 넣을 element
  var element_layer = document.getElementById('layer');
  // 테스트용 url
  var url = "https://www.sandbox.paypal.com/cgi-bin/webscr";
  // 실제 url
  // var url = "https://www.paypal.com/cgi-bin/webscr";
  var email = "skytosee-facilitator@gmail.com";
  
  $(document).ready(function(){  
	  // 계산
	  calcAll();
	  
	  // iframe을 넣은 element를 안보이게 한다.
  	  element_layer.style.display = 'none';
  	
  	  // 우편번호 찾기 클릭
  	  $("#btn_zip").on("click", function(e){	
  		e.preventDefault();
  		execDaumPostcode();       
	  });	
	  
	  // 주문 버튼
	  $('#btnOrder').click(function() {
		  saveOrder();
		  var id = $("#user_id").val();
		  postToUrl(url, 
				  { 'cmd': '_xclick',
			        'business': email,
			        'item_name': $('#sum_nm').val(),
			        'item_number':  $('#sum_cd').val(),
			        'currency_code': 'USD',
			        'amount': $('#sum_am').val(),
			        'charset': 'UTF-8',
			        'return': 'http://localhost:8080/order/checkout.do?id=' + id,
			        'notify_url': 'http://localhost:8080/order/notify.do',
			        'cancel_return': 'http://localhost:8080/order/cancel.do'
			      });	  
	  });
	  
	  // 삭제 버튼
	  $('#btnCancel').click(function() {
		  location.href = "/order/cart.do";
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
  	
  	calcAll();
  }
  
  //수량 변경
  function calcAll(){
	var sum_cd = "";
	var sum_am = 0;
	var sum_qt = 0;
	var count = 0;
	var strIndex = "am_".length;
	var id = "";
	var idFirst = "";
	$('[id^=am_]').each(function(index, element) {
		id = $(this)[0].id.substring(strIndex); 
		if (index == 0) {
			idFirst = id;
		}
		sum_cd += id + "|";
		sum_qt += Number($('#qt_' + id).val());
		sum_am += Number($(this)[0].value);
		count++;
	});
  	$('#sum_am').val(Money(sum_am));
  	$('#sum_vat').val(Money(Number(sum_am) / 10));
  	$('#sum_pay').val(Money(Number(sum_am) + (Number(sum_am) / 10)));
  	
  	$('#sum_cd').val(sum_cd);
  	if (count > 1)
  		$('#sum_nm').val($('#nm_' + idFirst).val() + " 외 " + (count - 1).toString() + "건");
  	else
  		$('#sum_nm').val($('#nm_' + idFirst).val());
  	$('#sum_qt').val(sum_qt);
  }
  
  // 주문저장
  function saveOrder() {
	 $.ajax({
	        url: '/order/orderSave.do',
	        type: "POST",
	        dataType: 'json',
	        data: { "dml_fg": "I", 
	                "ORDER_NB": "",
	        	    "ITEM_CD": $('#sum_cd').val(), 
	        	    "ITEM_NM": $('#sum_nm').val(),
	        	    "ITEM_QT": unMoney($('#sum_qt').val()),
	        	    "ITEM_AM": unMoney($('#sum_pay').val()),
	        	    "NAME": $('#inputName').val(),
	        	    "PHONE": $('#inputPhone').val(),
	        	    "ZIP": $('#inputZip').val(),
	        	    "ADDR": $('#inputAddr').val(),
	        	    "ORDER_FG": "0"
	        	  },
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
  
  // POST 전송
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
  
  
  // 다음 우편번호 서비스 호출
  function execDaumPostcode() {
      new daum.Postcode({
          oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
              var extraRoadAddr = ''; // 도로명 조합형 주소 변수

              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                  extraRoadAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if(data.buildingName !== '' && data.apartment === 'Y'){
                 extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              }
              // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if(extraRoadAddr !== ''){
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
              }
              // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
              if(fullRoadAddr !== ''){
                  fullRoadAddr += extraRoadAddr;
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('inputZip').value = data.zonecode; //5자리 새우편번호 사용
              document.getElementById('inputAddr').value = fullRoadAddr;  
              
              // iframe을 넣은 element를 안보이게 한다.
              // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
              element_layer.style.display = 'none';
          },
          width : '100%',
          height : '100%'
      }).embed(element_layer);
      
      // iframe을 넣은 element를 보이게 한다.
      element_layer.style.display = 'block';

      // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
      initLayerPosition();
  }
  
  function closeDaumPostcode() {
      // iframe을 넣은 element를 안보이게 한다.
      element_layer.style.display = 'none';
  }
  
  // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
  // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
  // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
  function initLayerPosition(){
      var width = 300; //우편번호서비스가 들어갈 element의 width
      var height = 460; //우편번호서비스가 들어갈 element의 height
      var borderWidth = 5; //샘플에서 사용하는 border의 두께

      // 위에서 선언한 값들을 실제 element에 넣는다.
      element_layer.style.width = width + 'px';
      element_layer.style.height = height + 'px';
      element_layer.style.border = borderWidth + 'px solid';
      // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
      element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
      element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
  }

  </script>
</body>
</html>
