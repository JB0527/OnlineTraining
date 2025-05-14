<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">


<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${contextRoot}/css/signup.css" />
  <link rel="stylesheet" as="style" crossorigin
    href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <title>Document</title>
</head>



<body>
  <header>
    <div class=" header">
      <div class="logo-box"><a href="${contextRoot}/"><img class="logo" src="${contextRoot}/images/logo.png"></a></div>
      <div class="header-right">
        <div><a href="${contextRoot}/user?action=login_form">로그인</a></div>
        <div>헬스장 찾기</div>
        <div class="user"><img src="${contextRoot}/images/user.png"></div>
      </div>
    </div>


  </header>

  <main class="container-box">
    <div class="title">회원가입</div>

    <form action="${contextRoot}/user" method="post">
    <input type="hidden" name="action" value="signup" />
      <div class="input-box">
        <div>
          <label for="id">아이디</label><input id="id" name="id" placeholder="아이디를 입력해주세요" />
        </div>
        <div>
          <label for="name">이름</label><input id="name" name="name" placeholder="이름을 입력해주세요" />
        </div>
        <div>
          <label for="email">이메일</label><input type="email" id="email" name="email" placeholder="이메일을 입력해주세요" />
        </div>
        <div>
          <label for="password">비밀번호</label><input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요" />
        </div>
        <div>
          <label for="pscheck">비밀번호 확인</label><input type="password" id="pscheck" placeholder="비밀번호를 입력해주세요" />
        </div>
      </div>
      <hr />
      <c:if test="${not empty message}"><a style="color: red">${message}</a></c:if>
      <div class="button-box">
        <button class="signup">가입</button>
        <div class="explain-text"> 이미 아이디가 있으시다면?</div>
      </div>
    </form>
		<button class="signin">
			<a href="${contextRoot}/user?action=login_form">로그인</a>
		</button>
	</main>
  <footer>
    <div class="footer-text">
      <p>고객센터</p>
      <p>서비스 이용약관</p>
      <p>개인정보 처리방침</p>
      <p>도움말</p>
    </div>

    <div class="footer-extra">
      <p>(주) <b>SSAFIT 대표 : 빈용쭌</b> </p>
      <p>서울특별시 강남구 테헤란로 212 멀티캠퍼스 역삼 504 </p>
      <p>사업자등록번호 : 000-00-00000 유료직업소개사업등록번호: (국내) 제0000-0000000-00-0-00000호</p>
    </div>
  </footer>
</body>

</html>