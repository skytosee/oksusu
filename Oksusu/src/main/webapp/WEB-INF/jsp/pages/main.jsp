<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
    <!-- 광고 -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img class="first-slide" src="<c:url value='/images/main/main2.jpg'/>" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
            </div>
          </div>
        </div>
        <div class="item">
          <img class="second-slide" src="<c:url value='/images/main/main3.jpg'/>" alt="Second slide">
          <div class="container">
            <div class="carousel-caption">
              <p>(경고) 과다 섭취 주의</p>    
            </div>
          </div>
        </div>
        <div class="item">
          <img class="third-slide" src="<c:url value='/images/main/main1.jpg'/>" alt="Third slide">
          <div class="container">
            <div class="carousel-caption">
              <p><a class="btn btn-lg btn-primary" href="#" role="button">히트다잉</a></p>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    <!-- 광고 -->
    
    <!-- 베스트 상품 -->
    <p style="text-align:center">
      <img src="<c:url value='/images/main/allkill.png'/>" alt="All Kill" height="60px">
    </p>
    <div class="container marketing">
      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-4">
          <img class="img-circle" src="<c:url value='/images/main/killer1.gif'/>" alt="더존 옥수수" width="140" height="140">
          <h2>더존 옥수수</h2>
          <p>친환경 무농약 강촌 생산 생옥수수</p>
          <p><a class="btn btn-default" href="#" role="button">보러가기 &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="<c:url value='/images/main/killer2.jpg'/>" alt="허니버터 옥수수" width="140" height="140">
          <h2>허니버터 옥수수</h2>
          <p>한땀 한땀 수제 허니 버터 옥수수</p>
          <p><a class="btn btn-default" href="#" role="button">보러가기 &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="<c:url value='/images/main/killer3.jpg'/>" alt="Generic placeholder image" width="140" height="140">
          <h2>쫀득 찰옥수수</h2>
          <p>쫀득 쫀득 이빨빠진 찰옥수수</p>
          <p><a class="btn btn-default" href="#" role="button">보러가기 &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
    </div>
    <!-- 베스트 상품 -->  
    
    <!-- 판매문의 -->
    <div class="jumbotron">
      <h2>Oksusu 판매문의</h2>
      <p>옥수수에 관한 제품의 판매를 원하십니까? 옥수수의 모든것! 옥수수 전문판매 쇼핑몰 Oksusu 에 문의 바랍니다.</p>
      <p>
        <a class="btn btn-success active" href="../../components/#navbar" role="button">판매하기 &raquo;</a>
      </p>
    </div>
    <!-- 판매문의 -->
     
</body>
</html>
