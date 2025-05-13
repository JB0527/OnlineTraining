 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="jakarta.tags.core" %>
 <c:set var="contextRoot" value="${pageContext.request.contextPath }" />
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
        <div class="iframe">
            <iframe width="560" height="315" src="${url} "
                title="YouTube video player" frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        </div>
        
        <hr>
        <div class="container">
        <c:choose>
        <c:when test="${not empty sessionScope.id}">
        
       		<form action="${pageContext.request.contextPath}/reviewServlet?" method="post">
               <div class="first">
               		<input type="hidden" name="videoId" value="${videoId}"> 
               		<input type="hidden" name="action" value="review_write">
            		<input type="submit" value="리뷰 작성">
             	</div>
            </form>
            </c:when>
            <c:otherwise>
            <h5 style="font-weight: 600; color: #3c526b;">로그인해야 리뷰 작성이 가능합니다.</h5>
            </c:otherwise>
            </c:choose>
          
            <div class="end">
                <form action="${pageContext.request.contextPath}/reviewServlet" method="post" }>
                <input type="hidden" name="videoId" value="${videoId}"> 
                <input type="hidden" name="action" value="review_search">
                🔍<input type="text" id="search" name="reviewSearch" placeholder="제목, 내용으로 검색">      
                </form>
                
          

            </div>
            <hr>

            <div class="list">
                <div class="num">번호</div>
                <div class="subject">제목</div>
                <div class="writer">작성자</div>
                <div class="click">조회수</div>
                <div class="time">작성시간</div>
            </div>
            <hr class="list_line">
            
            <c:if test="${empty reviewList}">
            <span style="margin: auto;">검색 결과가 없습니다.</span>
            </c:if>

			<c:forEach var="review" items="${reviewList}">
				<c:if test="${review.videoId == param.videoId}"> 
			      <div class="list">
              	 	  <div class="num">${review.reviewId}</div>
              	 	  <div class="subject">
              	 	   <a href="${pageContext.request.contextPath}/reviewServlet?action=review_detail&reviewId=${review.reviewId}&countchange=1">
              		  	${review.title}
              		  </a>       
              		  </div>    		  
             		  <div class="writer">
             		  <c:if test="${empty review.writer}" >
             		  익명의 누군가
             		  </c:if>
             		  ${review.writer}
             		  </div>
             		  <div class="click">${review.clickCount}</div>
             		  <div class="time">${review.writedTime}</div>
          		  </div>
				</c:if>

            </c:forEach>

            <div class="pagination">
                <input type="button" class="page" value="&lt" /> 
                <input type="button" class="page" value="1" />
                <input type="button" class="page" value="&gt" />
            </div>

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