<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<body>
<br/>
  <div style="text-align: center;">
	<h2>결제가 취소 되었습니다.</h2>
    <br/>
	<p>다시는 그러지 마세요!!!</p>
  </div>

  <script type="text/javascript">
  $(document).ready(function(){  
	  // 주문취소
	  //saveOrder();
  });
  
  // 주문취소
  function saveOrder() {
	 $.ajax({
	        url: '/order/orderSave.do',
	        type: "POST",
	        dataType: 'json',
	        data: { "dml_fg": "D", 
	                "ORDER_NB": "",
	        	    "ITEM_CD": "", 
	        	    "ITEM_NM": "",
	        	    "ITEM_QT": "",
	        	    "ITEM_AM": "",
	        	    "NAME": "",
	        	    "PHONE": "",
	        	    "ZIP": "",
	        	    "ADDR": "",
	        	    "ORDER_FG": "0"
	        	  },
	        async: false,
	        cache: false,
	        success: function(data) {
		    },
	        error:function(request,status,error){
	        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
	 });
  } 
  </script >
</body>
</html>