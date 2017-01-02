<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
  <div style="max-width:300px; margin:0 auto;">
      <form class="form-signin" method="post" action="loginProcess.do">
        <h2 class="form-signin-heading">로그인</h2>
        <label for="inputEmail" class="sr-only">아이디</label>
        <input type="text" id="userId" name="userId" class="form-control" placeholder="ID" required autofocus>
        <label for="inputPassword" class="sr-only">패스워드</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me" name="saveId"> 아이디저장
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
        <br/>
        <p style="color:red;">${MSG}</p>
      </form>
  </div>
</body>
</html>