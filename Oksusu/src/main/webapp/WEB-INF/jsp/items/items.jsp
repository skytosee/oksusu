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
    <div class="container marketing">
    <br/>
    <c:choose>
	    <c:when test="${fn:length(list) > 0}">
	         <c:forEach items="${list}" var="row" varStatus="status">
	             <c:if test="${status.index%3 == 0}">
	             	<div class="row">
	             </c:if>
	             <div class="col-lg-4">
	                 <c:choose>
	                 <c:when test="${row.STORED_IMG_NAME ne ''}">
	                 	<img class="img-circle" src="<c:url value='/files/${row.STORED_IMG_NAME}' />" alt="${row.ITEM_NM }" width="140" height="140">
	                 </c:when>
	                 <c:otherwise>
	                 	<img class="img-circle" src="<c:url value='/images/item/NoImage.png' />" alt="${row.ITEM_NM }" width="140" height="140">
	                 </c:otherwise>
	                 </c:choose>
	                 <h2>${row.ITEM_NM }</h2>
	                 <p>${row.ITEM_DC }</p>
	                 <p style="color:#3399ff;">${row.PRICE} 원</p>
	                 <div>
		                 <p style="display: inline; margin-right: 0px;"><a class="btn btn-default" href="#" role="button" id="${row.ITEM_CD}" onclick="cartClick(this);">장바구니 &raquo;</a></p>
		                 <p style="display: inline; margin-left: 0px;"><a class="btn btn-warning" href="#" role="button" id="${row.ITEM_CD}" onclick="orderClick(this);">주문하기 &raquo;</a></p>
		             </div>    
	             </div>
	             <c:if test="${status.index%3 == 2 || status.index == (fn:length(list) - 1)}">
	             	</div>
	             </c:if>
	         </c:forEach>
		</c:when>
	</c:choose>
	</div>
	
	<script type="text/javascript">
	function cartClick(btn){
		saveCart(btn.id);
	}
	
	function orderClick(btn){
		var id = btn.id;
	    var order = new Array();
	
		var ietm = new Object();
		$.ajax({
		        url: '/items/itemSelect.do',
		        type: "GET",
		        data: { "type": "", "view_yn": "", "item_cd": id },
		        async: false,
		        cache: false,
		        success: function(data) {
		        	var contact = JSON.parse(data);
		        	ietm.ITEM_CD = id;
		    		ietm.ITEM_NM = contact[0].ITEM_NM;
		    		ietm.ITEM_DC = contact[0].ITEM_DC;
		    		ietm.PRICE = contact[0].PRICE;
		    		ietm.ITEM_QT = 1;
		    		ietm.ITEM_AM = contact[0].PRICE;  
		    	    order.push(ietm);  
			    },
		        error:function(request,status,error){
		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        }
		});

		postToUrl('/order/list.do', {'list': JSON.stringify(order)});
	}
	
	function saveCart(id) {
		 $.ajax({
		        url: '/order/cartSave.do',
		        type: "POST",
		        dataType: 'json',
		        data: { "dml_fg": "I", "id": id, "qt": 1 },
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
	
	// post 전송
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
