<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap cdn css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- css -->
<link rel="stylesheet" href="${contextRoot}/css/main.css">
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
							<a href="${contextRoot}/user?action=login_form">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="${contextRoot}/user?action=logout">로그아웃</a>
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
	<main>
		<div class="container" id="searchbar">
			<form action="${contextRoot }/main">
				<div class="d-flex">
				<input type="hidden" name="action" value="search">
					<img src="${contextRoot}/images/search.png"> <input
						type placeholder="운동 제목 검색" name="content">
				</div>
			</form>
		</div>

		<%----------------------------------------------------------------------------------------------------------------------------------------------%>
		<input type="hidden" class="tag" type="button" value="전신" id="부위">


		<div class="container" id="최근영상">
			<h5 style="font-weight: 600; color: #3c526b;">최근 가장 많이 본 영상</h5>
			<div class="row">

				<c:forEach var="i" begin="0" end="2" step="1">
					<div class="box col-4">
						<div class="ratio ratio-16x9">
							<iframe src="${exers[i].url}" width:400px height:300px
								allowfullscreen></iframe>
						</div>
						<div class="row" id="제목">
							<a
								href="${contextRoot}/reviewServlet?action=review_list&videoId=${exers[i].videoId}">${exers[i].getTitle()}</a>
						</div>
					</div>
				</c:forEach>
				<%-- for문 --%>
			</div>
			<%-- row --%>
		</div>
		<%--container --%>

		<%----------------------------------------------------------------------------------------------------------------------------------------------%>


		<div class="container" id="운동부위">
			<h5 style="font-weight: 600; color: #3c526b;">운동 부위 선택</h5>
			<a href="${contextRoot}/main?part=all">전체</a> <a
				href="${contextRoot}/main?part=whole">전신</a> <a
				href="${contextRoot}/main?part=upper">상체</a> <a
				href="${contextRoot}/main?part=lower">하체</a> <a
				href="${contextRoot}/main?part=abdomen">복부</a>
			<div class="row">


				<c:choose>
					<c:when test="${part == 'all'}">
						<c:forEach var="i" begin="0" end="2" step="1">
							<div class="box col-4">
								<div class="ratio ratio-16x9">
									<iframe src="${exers[i].url}" width:400px height:300px
										allowfullscreen></iframe>
								</div>
								<div class="row" id="제목">
									<a
										href="${contextRoot}/reviewServlet?action=review_list&videoId=${exers[i].videoId}">${exers[i].title}</a>
								</div>
							</div>
						</c:forEach>
						<%-- for문 --%>
					</c:when>
					<c:otherwise>
						<c:forEach var="exer" items="${exers}">
							<c:if test="${exer.part == part}">
								<div class="box col-4">
									<div class="ratio ratio-16x9">
										<iframe src="${exer.url}" width:400px height:300px
											allowfullscreen></iframe>
									</div>
									<div class="row" id="제목">
										<a
											href="${contextRoot}/reviewServlet?action=review_list&videoId=${exer.videoId}">${exer.title}</a>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<%-- for문 --%>
					</c:otherwise>
				</c:choose>


			</div>
			<%-- row --%>
		</div>
		<%--container --%>
	</main>
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

	<!-- bootstrap cdn js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

</body>
</html>
