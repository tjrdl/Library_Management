<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>잉크 트리 - 도서관리 시스템</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/main.css">

</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<%
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		if (user != null) {
		%>

		<div class="welcome-banner">
			<div class="welcome-text">
				<h1>
					안녕하세요,
					<%=user.getUserName()%>님!
				</h1>
				<p>잉크 트리 도서관리 시스템에 오신 것을 환영합니다.</p>
			</div>
			<div class="date-display">
				<i class="fas fa-calendar-alt"></i> <span id="current-date">
					<%=new java.text.SimpleDateFormat("yyyy년 MM월 dd일 EEEE", java.util.Locale.KOREAN).format(new java.util.Date())%>
				</span>
			</div>
		</div>

		<!-- Search Box at the top -->
		<div class="search-box">
			<h3>
				<i class="fas fa-search"></i> 도서 검색
			</h3>
			<form action="/pilotpjt/book_search" method="GET" class="search-form">
				<input type="text" name="keyword" placeholder="도서명, 저자, 출판사 등으로 검색"
					class="search-input">
				<button type="submit" class="search-button">
					<i class="fas fa-search"></i> 검색
				</button>
			</form>
		</div>

		<!-- Statistics Dashboard -->
		<div class="stats-dashboard">
			<div class="stat-card">
				<div class="stat-icon books">
					<i class="fas fa-book"></i>
				</div>
				<div class="stat-info">
					<h3>전체 도서</h3>
					<div class="number">
						<fmt:formatNumber value="${totalBooks}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon users">
					<i class="fas fa-users"></i>
				</div>
				<div class="stat-info">
					<h3>전체 회원</h3>
					<div class="number">
						<fmt:formatNumber value="${totalUsers}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon borrowed">
					<i class="fas fa-book-reader"></i>
				</div>
				<div class="stat-info">
					<h3>대출 중인 도서</h3>
					<div class="number">
						<fmt:formatNumber value="${borrowedBooks}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon overdue">
					<i class="fas fa-exclamation-circle"></i>
				</div>
				<div class="stat-info">
					<h3>연체 도서</h3>
					<div class="number">
						<fmt:formatNumber value="${overdueBooks}" type="number" />
					</div>
				</div>
			</div>
		</div>

		<!-- Smaller Feature Cards -->
		<div class="feature-section">
			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-book-open"></i>
				</div>
				<div class="feature-content">
					<h3>내 대출 현황</h3>
					<p>현재 대출 중인 도서와 반납 예정일을 확인하세요.</p>
					<a href="/pilotpjt/my_books" class="btn-sm">바로가기</a>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-exchange-alt"></i>
				</div>
				<div class="feature-content">
					<h3>도서 대출</h3>
					<p>원하는 도서를 대출하여 이용하세요.</p>
					<a href="/pilotpjt/book_borrow" class="btn-sm">바로가기</a>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="feature-content">
					<h3>도서 추천</h3>
					<p>회원님의 관심사에 맞는 도서를 추천해 드립니다.</p>
					<a href="/pilotpjt/book_recommendation" class="btn-sm">바로가기</a>
				</div>
			</div>
		</div>

		<!-- Recommended Books -->
		<div class="recommended-books">
			<div class="section-header">
				<h2 class="section-title">
					<i class="fas fa-thumbs-up"></i> 추천 도서
				</h2>
				<a href="/pilotpjt/recommended_books" class="action-link"> 더보기 <i
					class="fas fa-chevron-right"></i>
				</a>
			</div>


			<div class="books-grid">
				<c:forEach var="book" items="${bookList}" varStatus="status">
					<c:if test="${status.index <4}">
						<div class="book-card">
							<div class="book-cover">
								<img src="/pilotpjt/resources/images/book1.jpg" alt="도서 표지"
									onerror="this.src='/pilotpjt/resources/images/default-book.jpg'; this.onerror=null;">
							</div>
							<div class="book-info">
								<h3 class="book-title">${book.bookTitle}</h3>
								<p class="book-author">${book.bookWrite}</p>

								<c:choose>
									<c:when test="${book.bookCount == 0}">
										<span class="book-status status-borrowed">대출 중</span>
									</c:when>
									<c:otherwise>
										<span class="book-status status-available">대출 가능</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</c:if>
				</c:forEach>

				<!-- 				<div class="book-card"> -->
				<!-- 					<div class="book-cover"> -->
				<!-- 						<img src="/pilotpjt/resources/images/book1.jpg" alt="도서 표지" -->
				<!-- 							onerror="this.src='/pilotpjt/resources/images/default-book.jpg'; this.onerror=null;"> -->
				<!-- 					</div> -->
				<!-- 					<div class="book-info"> -->
				<%-- 						<h3 class="book-title">${bookTitle }Model로값 넣어줘야함</h3> --%>
				<%-- 						<p class="book-author">${bookWrite }</p> --%>
				<%-- 						<span class="book-status status-available">${bookCount}</span> --%>
				<!-- 					</div> -->
				<!-- 				</div> -->


				<!-- 				<div class="book-card"> -->
				<!-- 					<div class="book-cover"> -->
				<!-- 						<img src="/pilotpjt/resources/images/book2.jpg" alt="도서 표지" -->
				<!-- 							onerror="this.src='/pilotpjt/resources/images/default-book.jpg'; this.onerror=null;"> -->
				<!-- 					</div> -->
				<!-- 					<div class="book-info"> -->
				<!-- 						<h3 class="book-title">객체지향의 사실과 오해</h3> -->
				<!-- 						<p class="book-author">조영호</p> -->
				<!-- 						<span class="book-status status-borrowed">대출 중</span> -->
				<!-- 					</div> -->
				<!-- 				</div> -->

				<!-- 				<div class="book-card"> -->
				<!-- 					<div class="book-cover"> -->
				<!-- 						<img src="/pilotpjt/resources/images/book3.jpg" alt="도서 표지" -->
				<!-- 							onerror="this.src='/pilotpjt/resources/images/default-book.jpg'; this.onerror=null;"> -->
				<!-- 					</div> -->
				<!-- 					<div class="book-info"> -->
				<!-- 						<h3 class="book-title">이것이 자바다</h3> -->
				<!-- 						<p class="book-author">신용권</p> -->
				<!-- 						<span class="book-status status-available">대출 가능</span> -->
				<!-- 					</div> -->
				<!-- 				</div> -->

				<!-- 				<div class="book-card"> -->
				<!-- 					<div class="book-cover"> -->
				<!-- 						<img src="/pilotpjt/resources/images/book4.jpg" alt="도서 표지" -->
				<!-- 							onerror="this.src='/pilotpjt/resources/images/default-book.jpg'; this.onerror=null;"> -->
				<!-- 					</div> -->
				<!-- 					<div class="book-info"> -->
				<!-- 						<h3 class="book-title">모던 자바스크립트 Deep Dive</h3> -->
				<!-- 						<p class="book-author">이웅모</p> -->
				<!-- 						<span class="book-status status-available">대출 가능</span> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
			</div>
		</div>

		<%
		} else {
		%>
		<div class="login-section">
			<h2>도서관리 시스템에 오신 것을 환영합니다</h2>
			<p>
				잉크 트리 도서관리 시스템은 다양한 도서를 검색하고 대출할 수 있는 서비스를 제공합니다.<br>서비스를
				이용하시려면 로그인이 필요합니다.
			</p>
			<a href="/pilotpjt/loginView" class="btn"> <i
				class="fas fa-sign-in-alt"></i> 로그인 하러 가기
			</a>
			<p style="margin-top: 20px;">
				계정이 없으신가요? <a href="joinView">회원가입</a>
			</p>
		</div>
		<%
		}
		%>
	</div>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate statistics numbers
            const statNumbers = document.querySelectorAll('.number');
            
            statNumbers.forEach(number => {
                const finalValue = number.textContent;
                let startValue = 0;
                const duration = 1500;
                const increment = parseInt(finalValue.replace(/,/g, '')) / (duration / 20);
                
                const animateValue = () => {
                    startValue += increment;
                    if (startValue < parseInt(finalValue.replace(/,/g, ''))) {
                        number.textContent = Math.floor(startValue).toLocaleString();
                        requestAnimationFrame(animateValue);
                    } else {
                        number.textContent = finalValue;
                    }
                };
                
                requestAnimationFrame(animateValue);
            });
        });
    </script>
</body>
</html>