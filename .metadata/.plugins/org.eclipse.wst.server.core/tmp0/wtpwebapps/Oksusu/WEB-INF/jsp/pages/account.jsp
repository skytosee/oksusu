<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script src="<c:url value='/js/parsley.min.js'/>"></script>
    <script src="<c:url value='/js/ko.js'/>"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
    <br/>
    <form class="form-horizontal" method="post" action="accountProcess.do" id="accountForm" data-parsley-validate="">
	  <div class="form-group">
	    <label for="inputId" class="col-sm-2 control-label">아이디</label>
	    <div class="col-sm-3">
	      <input name="userId" class="form-control" id="inputId" placeholder="ID">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword" class="col-sm-2 control-label">패스워드</label>
	    <div class="col-sm-3">
	      <input name="password" type="password" class="form-control" id="inputPassword" placeholder="Password" data-parsley-trigger="change"
	             data-parsley-minlength="4">
	    </div>
	  </div>
	   <div class="form-group">
	    <label for="inputPassword2" class="col-sm-2 control-label">패스워드확인</label>
	    <div class="col-sm-3">
	      <input name="password2" type="password" class="form-control" id="inputPassword2" placeholder="Password" data-parsley-trigger="change"
	             data-parsley-minlength="4">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputName" class="col-sm-2 control-label">이름</label>
	    <div class="col-sm-3">
	      <input name="userName" class="form-control" id="inputName" placeholder="Name">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputEmail" class="col-sm-2 control-label">이메일</label>
	    <div class="col-sm-3">
	      <input name="email" type="email" class="form-control" id="inputEmail" placeholder="Email" data-parsley-trigger="change">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPhone" class="col-sm-2 control-label">연락처</label>
	    <div class="col-sm-3">
	      <input name="phone" type="number" class="form-control" id="inputPhone" placeholder="Phone">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputZip" class="col-sm-2 control-label">우편번호</label>
	    <div class="col-sm-2">
	      <input name="zip" type="number" class="form-control" id="inputZip" placeholder="zip">
	    </div>
	    <button class="btn btn-success" id="btn_zip">주소찾기</button>
	  </div>
	  <div class="form-group">
	    <label for="inputAddr" class="col-sm-2 control-label">주소</label>
	    <div class="col-sm-10">
	      <input name="address" class="form-control" id="inputAddr" placeholder="address">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-default">회원가입</button>
	    </div>
	  </div>
	</form>
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

    <script type="text/javascript">
        // 우편번호 찾기 화면을 넣을 element
        var element_layer = document.getElementById('layer');
 
        $(document).ready(function(){  
        	// iframe을 넣은 element를 안보이게 한다.
        	element_layer.style.display = 'none';
        	
	    	// 우편번호 찾기 클릭
	    	$("#btn_zip").on("click", function(e){	
	    		e.preventDefault();
	    		execDaumPostcode();       
			});	
	    	
	    	$('#accountForm').parsley().on('field:validated', function() {
	    	    var ok = $('.parsley-error').length === 0;
	    	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    	    $('.bs-callout-warning').toggleClass('hidden', ok);
	    	  })
	    	  .on('form:submit', function() {
	    	  });
	    });
	    
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