<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="jakarta.tags.core" %>
 <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%--현재 시간 저장하려고 --%>
  <c:set var="contextRoot" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동 리뷰 작성</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- css -->
<link rel="stylesheet" href="${contextRoot}/css/review.css">
</head>
<body>
<header>
		<div class=" header">
			<div class="logo-box">
				<a href="${contextRoot}/"><img class="logo"
					src="${contextRoot}/images/logo.png"></a>
			</div>
			<div class="header-right">
				<div>
					<c:choose>
						<c:when test="${empty sessionScope.id}">
							<a href="${contextRoot}/user?action=login_form" class="login">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="${contextRoot}/user?action=logout" class="logout">로그아웃</a>
						</c:otherwise>
					</c:choose>

				</div>
				<div>헬스장 찾기</div>
				<div class="user">
					<img src="${contextRoot}/images/user.png">
				</div>
			</div>
		</div>
	</header>
 <div class="container-body">
        <div class = "review">
            <div class="exercisegif"></div>
            <div>
                <h1>운동영상 리뷰</h1>
            </div>
            <div class="exercisegif"></div>
        </div>

        <hr>
		<div class="container">
		<form action="${pageContext.request.contextPath}/reviewServlet" style="display:flex; width: 100%; justify-content: end">
					<input type="hidden" name="action" value="review_list" /> <input
						type="hidden" name="videoId" value="${param.videoId}" />
					<button>목록</button>
				</form>
			<form action="${pageContext.request.contextPath}/reviewServlet"
				method="post" style="width: 100%; display:inline;">
				<input type="hidden" name="videoId" value="${param.videoId}">
				<input type="hidden" name="action" value="review_regist">

				<div class="title">
					제목 <input type="text" name=title placeholder="제목을 입력하세요" required />
				</div>

				<div class="content">
					<p>내용</p>
					<textarea name="content" placeholder="내용을 입력하세요" required></textarea>
				</div>
				<input type="submit" name="enroll" value="등록" />
			</form>
				
		</div>

	</div>
<footer>
		<div class="footer-text">
			<p>고객센터</p>
			<p>서비스 이용약관</p>
			<p>개인정보 처리방침</p>
			<p>도움말</p>
		</div>

		<div class="footer-extra">
			<p>
				(주) <b>SSAFIT 대표 : 옥준</b>
			</p>
			<p>서울특별시 강남구 테헤란로 212 멀티캠퍼스 역삼 504</p>
			<p>사업자등록번호 : 000-00-00000 유료직업소개사업등록번호: (국내)
				제0000-0000000-00-0-00000호</p>
		</div>
	</footer>
</body>
</html>