<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세</title>

<!-- bootstrap cdn css -->
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
		<div class="review">
			<div class="exercisegif"></div>
			<div>
				<h1>운동영상 리뷰</h1>
			</div>
			<div class="exercisegif"></div>
		</div>
		<hr>
		<div class="container">

			<form action="${pageContext.request.contextPath}/reviewServlet"
				style="display: flex; width: 100%; justify-content: end">
				<input type="hidden" name="action" value="review_list" /> <input
					type="hidden" name="videoId" value="${review.videoId}" />
				<button>목록</button>
			</form>

			<div class="title">
				<input type="text" value="${review.title}" disabled />
			</div>
			<div class="content">
				<textarea disabled>${review.content}</textarea>

			</div>
			<c:if test="${review.writerId eq sessionScope.id}">
			<c:if test="${not empty sessionScope.id}">
				<input type="button" id="edit" name="enroll" value="글수정"
					onClick="location.href='${contextRoot}/reviewServlet?action=review_update_form&reviewId=${review.reviewId}'" />

				<form action="${pageContext.request.contextPath}/reviewServlet">
					<input type="hidden" name="action" value="review_delete" /> <input
						type="hidden" name="videoId" value="${review.videoId}" /> <input
						type="hidden" name="reviewId" value="${review.reviewId}" />
					<button class="cancel">글 삭제</button>
				</form>
			</c:if>
			</c:if>
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