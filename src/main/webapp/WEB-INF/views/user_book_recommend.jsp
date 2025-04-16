<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>도서 추천</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/user_book_recommend.css">
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="recommendation-header">
			<div class="header-content">
				<h1 class="recommendation-title">
					<span class="title-icon"><i class="fas fa-book-reader"></i></span>
					<span class="title-text">맞춤 도서 추천 시스템</span>
				</h1>
				<p class="recommendation-subtitle">${loginUser.userName}님의 관심
					카테고리와 인기 도서를 기반으로 추천해드립니다.</p>
			</div>
		</div>

		<!-- 인기 대출 도서 폼 -->
		<form class="popular-form">
			<div class="form-header">
				<h2 class="form-title">
					<span class="title-icon"><i class="fas fa-star"></i></span> <span
						class="title-text">인기 대출 도서</span>
				</h2>
				<p class="form-description">가장 많이 대출된 인기 도서를 확인해보세요.</p>
			</div>

			<div class="book-carousel">
				<%--                 <c:forEach items="${list}" var="book" varStatus="status"> --%>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book1.png" alt="책1"
							style="width: 100%; height: 75%; object-fit: contain;">
						<div class="book-info">
							<div class="info-row">
								<div class="book-title" style="font-size: 20px; color: black; font-weight: bold;">제목 : 머리부터 천천히</div>
								<div class="book-author">저자 : 정재윤</div>
							</div>
							<div class="book-category">장르 : 호러</div>
							<div class="book-date">출판일 : BC-500</div>
						</div>
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book2.png" alt="책2"
							style="width: 100%; height: 75%; object-fit: contain;">
						<div class="book-info">
							<div class="info-row">
								<div class="book-title" style="font-size: 20px; color: black; font-weight: bold;">제목 : 첫 숨</div>
								<div class="book-author">저자 : 이병훈</div>
							</div>
							<div class="book-category">장르 : 사극</div>
							<div class="book-date">출판일 : 1592-09-21</div>
						</div>
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book3.png" alt="책3"
							style="width: 100%; height: 75%; object-fit: contain;">
						<div class="book-info">
							<div class="info-row">
								<div class="book-title" style="font-size: 20px; color: black; font-weight: bold;">제목 : 애니</div>
								<div class="book-author">저자 : 정종현</div>
							</div>
							<div class="book-category">장르 : 로맨스</div>
							<div class="book-date">출판일 : 2353-05-07</div>
						</div>
					</div>
				</div>
				<%--                 </c:forEach> --%>
			</div>
		</form>
		<!-- 주 카테고리 추천 폼 -->
		<form class="category-form">
			<div class="form-header">
				<h2 class="form-title">
					<span class="title-icon"><i class="fas fa-bookmark"></i></span> <span
						class="title-text">${topMajorCategory} 당신을 위한 추천</span>
				</h2>
				<p class="form-description">${loginUser.userName}님이 가장 많이 읽은 주요
					카테고리 기반 추천 도서입니다.</p>
			</div>

			<div class="book-grid">
				<%--                 <c:forEach items="${majorCategoryBooks}" var="book"> --%>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book4.png" alt="책4"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book5.png" alt="책5"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book6.png" alt="책6"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book7.png" alt="책7"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book8.png" alt="책8"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<%--                 </c:forEach> --%>
			</div>
		</form>

		<!-- 서브 카테고리 추천 폼 -->
		<form class="category-form">
			<div class="form-header">
				<h2 class="form-title">
					<span class="title-icon"><i class="fas fa-tags"></i></span> <span
						class="title-text">${topSubCategory} 이런 건 어떠세요</span>
				</h2>
				<p class="form-description">${loginUser.userName}님이 관심이 있을 수도 있는
					책리스트 입니다.</p>
			</div>

			<div class="book-grid">
				<%-- 				<c:forEach items="${subCategoryBooks}" var="book"> --%>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book9.png" alt="책9"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book10.png" alt="책10"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book11.png" alt="책11"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book12.png" alt="책12"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<div class="book-card">
					<div class="book-cover">
						<img src="../pilotpjt/resources/images/book13.png" alt="책13"
							style="width: 100%; height: 101%; object-fit: cover;">
					</div>
				</div>
				<%-- 				</c:forEach> --%>
			</div>
		</form>
	</div>
</body>
</html>
