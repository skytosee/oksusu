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
			          <p><b>${row.ORDER_NB}</b></p>
			        </div>
			         <div class="col-md-2">
			          <p>${row.ITEM_CD}</p>
			        </div>   
			        <div class="col-md-3">
			          <p>${row.ITEM_NM}</p>
			        </div> 
			        <div class="col-md-1">
			          <c:choose>
		                  <c:when test="${row.ORDER_FG eq 0}">
				            <p style="color:red;">${row.STATE_NM}</p>
				          </c:when>
				          <c:when test="${row.ORDER_FG eq 1}">
				            <p style="color:orange;">${row.STATE_NM}</p>
				          </c:when>
				          <c:when test="${row.ORDER_FG eq 2}">
				            <p style="color:blue;">${row.STATE_NM}</p>
				          </c:when>
				          <c:otherwise>
						    <p>${row.STATE_NM}</p>
						  </c:otherwise>
	                  </c:choose>   
			        </div>   	
					<div class="col-md-2">  			
                      	<label for="qt_${row.ITEM_CD}" class="col-sm-4 control-label">수량</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" id="qt_${row.ITEM_CD}" value="${row.ITEM_QT}" style="text-align: right;" readonly >
					    </div>
					</div>  
					<div class="col-md-2">    
                      	<label for="am_${row.ITEM_CD}" class="col-sm-4 control-label">금액</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" id="am_${row.ITEM_CD}" value="${row.ITEM_AM}" style="text-align: right;" readonly >
					    </div> 
			        </div>
			     </div>  
			     <hr/>   
	         </c:forEach>
		</c:when>
	</c:choose>
  </div>
</body>
</html>
