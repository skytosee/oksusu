<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
    <!-- 헤더 -->
    <nav class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Oksusu</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="/about.do">궁금해?</a></li>
            <li><a href="/board/openBoardList.do">물어봐!</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">뭐사지<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="/items/live.do">생옥수수</a></li> 
                <li><a href="/items/fire.do">군옥수수</a></li>
                <li><a href="/items/steam.do">찐옥수수</a></li>
                <li class="divider"></li>
                <li><a href="/items/other.do">기타옥수수</a></li>
              </ul>
            </li>  
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <c:choose>
            	<c:when test="${not empty sessionScope.userLoginInfo}">
            	    <li role="presentation"><a href="/order/cart.do">장바구니<span class="badge">${sessionScope.userLoginInfo.cartCount}</span></a></li>
            	    <li class="dropdown">
		              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${sessionScope.userLoginInfo.userName}<span class="caret"></span></a>
		              <ul class="dropdown-menu" role="menu">
		                <li><a href="/logout.do">로그아웃</a></li> 
		                <li class="divider"></li>
		                <li><a href="#">내정보</a></li>
		                <li><a href="/order/order.do">주문정보</a></li>
		              </ul>
		            </li>
		            <c:if test="${not empty sessionScope.admin}">
			            <li class="dropdown">
			              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">관리자<span class="caret"></span></a>
			              <ul class="dropdown-menu" role="menu">
			                <li><a href="/admin/item.do">품목관리</a></li>
			                <li><a href="/admin/order.do">주문관리</a></li> 
			              </ul>
			            </li>
		            </c:if>
	            </c:when>
	            <c:otherwise> 
		            <li><a href="/login.do">로그인</a></li>
		            <li><a href="/account.do">회원가입</a></li>
		        </c:otherwise>    
            </c:choose>        
            <li><a href="#"></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <!-- 헤더 -->
</body>
</html>
