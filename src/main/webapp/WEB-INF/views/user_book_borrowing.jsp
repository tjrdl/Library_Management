<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 대출 도서 - 잉크 트리</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/user_book_borrowing.css">
<script type="text/javascript">
	function return_submit(button) {
		const form = button.closest("form");
		if (!form.checkValidity()) {
			form.reportValidity();
			return;
		}

		const formData = $(form).serialize();

		$.ajax({
			type : "post",
			data : formData,
			url : "book_return",
			success : function(data) {
				alert("정상적으로 반납되었습니다.");
				location.href = "user_book_borrowing";
			},
			error : function() {
				alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			}
		});
	}
	
	function showHistoryTab(tabId, event) {
		// 이벤트 버블링 방지
		if (event) {
			event.preventDefault();
		}
		
		// 모든 탭 버튼에서 active 클래스 제거
		const tabButtons = document.querySelectorAll('.tab-button');
		tabButtons.forEach(button => {
			button.classList.remove('active');
		});
		
		// 클릭된 버튼에 active 클래스 추가
		if (event && event.currentTarget) {
			event.currentTarget.classList.add('active');
		}
		
		// 모든 탭 컨텐츠 숨기기
		const tabContents = document.querySelectorAll('.tab-content');
		tabContents.forEach(content => {
			content.classList.remove('active');
		});
		
		// 선택된 탭 컨텐츠 표시
		document.getElementById(tabId).classList.add('active');
	}
	
	// 페이지 로드 후 실행
	window.addEventListener('DOMContentLoaded', function() {
		// 애니메이션 효과 추가
		const bookItems = document.querySelectorAll('.book-item');
		bookItems.forEach((item, index) => {
			setTimeout(() => {
				item.classList.add('show');
			}, 100 * index);
		});
		
		// 알림 메시지 처리
		const errorMsg = "${errorMsg}";
		const successMsg = "${return_successMSG}";
		const returnErrorMsg = "${return_errorMsg}";
		
		if (errorMsg && errorMsg !== "") {
			alert(errorMsg);
		}
		
		if (successMsg && successMsg !== "") {
			alert(successMsg);
		}
		
		if (returnErrorMsg && returnErrorMsg !== "") {
			alert(returnErrorMsg);
		}
	});
</script>
<style>
:root {
	--primary-color: #4361ee;
	--primary-light: #d8e1ff;
	--primary-lighter: #edf0ff;
	--primary-dark: #3a56d4;
	--secondary-color: #4895ef;
	--accent-color: #f72585;
	--success-color: #4cc9a0;
	--danger-color: #f72585;
	--warning-color: #fca311;
	--info-color: #4895ef;
	--gray-100: #f8f9fa;
	--gray-200: #e9ecef;
	--gray-300: #dee2e6;
	--gray-400: #ced4da;
	--gray-500: #adb5bd;
	--gray-600: #6c757d;
	--gray-700: #495057;
	--gray-800: #343a40;
	--gray-900: #212529;
	--border-radius: 12px;
	--box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	--transition: all 0.3s ease;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f5f7fa;
	color: var(--gray-800);
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 2rem auto;
	padding: 0 1.5rem;
}

/* 헤더 스타일 */
.borrowed-header {
	background-color: white;
	border-radius: var(--border-radius);
	box-shadow: var(--box-shadow);
	padding: 2.5rem;
	margin-bottom: 2rem;
	position: relative;
	overflow: hidden;
}

.borrowed-header::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 6px;
	background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
}

.header-content {
	max-width: 800px;
}

.borrowed-title {
	font-size: 2.2rem;
	font-weight: 700;
	margin-bottom: 0.8rem;
	display: flex;
	align-items: center;
	color: var(--gray-900);
}

.title-icon {
	margin-right: 1rem;
	font-size: 1.8rem;
	color: var(--primary-color);
	background-color: var(--primary-lighter);
	width: 50px;
	height: 50px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.borrowed-subtitle {
	font-size: 1.1rem;
	color: var(--gray-600);
	max-width: 80%;
}

.borrowed-stats {
	display: flex;
	gap: 1.5rem;
	margin-top: 2rem;
}

.stat-card {
	flex: 1;
	background-color: white;
	border-radius: var(--border-radius);
	padding: 1.5rem;
	display: flex;
	align-items: center;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	transition: var(--transition);
	border: 1px solid var(--gray-200);
}

.stat-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.stat-icon {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background-color: var(--primary-lighter);
	color: var(--primary-color);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	margin-right: 1rem;
}

.stat-icon.warning {
	background-color: #fff5e6;
	color: var(--warning-color);
}

.stat-icon.success {
	background-color: #e6fff0;
	color: var(--success-color);
}

.stat-info {
	flex-grow: 1;
}

.stat-value {
	font-size: 1.8rem;
	font-weight: 700;
	color: var(--gray-900);
	line-height: 1.2;
}

.stat-title {
	font-size: 0.9rem;
	color: var(--gray-600);
}

/* 탭 스타일 */
.tab-container {
	background-color: white;
	border-radius: var(--border-radius);
	box-shadow: var(--box-shadow);
	overflow: hidden;
	margin-top: 2rem;
}

.tab-buttons {
	display: flex;
	background-color: var(--gray-100);
	padding: 0.5rem;
	border-bottom: 1px solid var(--gray-200);
}

.tab-button {
	flex: 1;
	padding: 1rem 1.5rem;
	background: none;
	border: none;
	border-radius: 8px;
	font-weight: 500;
	font-size: 1rem;
	color: var(--gray-700);
	cursor: pointer;
	transition: all 0.3s ease;
	text-align: center;
}

.tab-button:hover {
	color: var(--primary-color);
	background-color: var(--primary-lighter);
}

.tab-button.active {
	color: white;
	background-color: var(--primary-color);
	box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
}

.tab-content {
	display: none;
	padding: 2rem;
}

.tab-content.active {
	display: block;
	animation: fadeIn 0.5s ease;
}

@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

/* 도서 목록 스타일 */
.book-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
	gap: 1.5rem;
}

.book-item {
	display: flex;
	background-color: white;
	border-radius: var(--border-radius);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	padding: 1.5rem;
	transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	border: 1px solid var(--gray-200);
	opacity: 0;
	transform: translateY(20px);
	position: relative;
	overflow: hidden;
}

.book-item::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 4px;
	height: 100%;
	background-color: var(--primary-color);
}

.book-item.show {
	opacity: 1;
	transform: translateY(0);
}

.book-item:hover {
	transform: translateY(-8px);
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
}

.book-cover {
	width: 90px;
	height: 130px;
	margin-right: 1.5rem;
	flex-shrink: 0;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.book-cover-placeholder {
	width: 100%;
	height: 100%;
	background: #e0e0e0;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 2rem;
}

.book-info {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
}

.book-title {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 0.5rem;
	color: var(--gray-900);
	line-height: 1.4;
}

.book-author {
	font-size: 0.95rem;
	color: var(--gray-700);
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
}

.book-author::before {
	content: '\f303';
	font-family: 'Font Awesome 6 Free';
	font-weight: 900;
	margin-right: 0.5rem;
	font-size: 0.8rem;
	color: var(--gray-500);
}

.book-dates {
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
	font-size: 0.85rem;
	color: var(--gray-600);
	margin-top: auto;
}

.book-dates span {
	display: flex;
	align-items: center;
}

.book-dates span::before {
	font-family: 'Font Awesome 6 Free';
	font-weight: 900;
	margin-right: 0.5rem;
	font-size: 0.8rem;
	color: var(--gray-500);
}

.book-dates span:first-child::before {
	content: '\f073';
}

.book-dates span:last-child::before {
	content: '\f017';
}

.book-status {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: space-between;
	margin-left: 1rem;
	min-width: 100px;
}

.status-borrowed {
	color: var(--primary-color);
	font-weight: 600;
	font-size: 0.9rem;
	background-color: var(--primary-lighter);
	padding: 0.3rem 0.8rem;
	border-radius: 20px;
	display: inline-flex;
	align-items: center;
}

.status-borrowed::before {
	content: '\f02e';
	font-family: 'Font Awesome 6 Free';
	font-weight: 900;
	margin-right: 0.5rem;
}

.status-returned {
	margin-top: auto;
}

.status-badge {
	display: inline-flex;
	align-items: center;
	gap: 0.4rem;
	padding: 0.3rem 0.8rem;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 500;
	background-color: var(--success-color);
	color: white;
}

.return-button {
	background-color: var(--primary-color);
	color: white;
	border: none;
	border-radius: 8px;
	padding: 0.7rem 1.2rem;
	font-size: 0.9rem;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
	box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
	margin-top: auto;
}

.return-button:hover {
	background-color: var(--primary-dark);
	transform: translateY(-2px);
	box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4);
}

.return-button:active {
	transform: translateY(0);
	box-shadow: 0 2px 5px rgba(67, 97, 238, 0.4);
}

/* 빈 상태 스타일 */
.empty-state {
	text-align: center;
	padding: 4rem 2rem;
	background-color: white;
	border-radius: var(--border-radius);
	animation: fadeIn 0.5s ease;
}

.empty-icon {
	font-size: 4rem;
	color: var(--gray-300);
	margin-bottom: 1.5rem;
	animation: float 3s ease-in-out infinite;
}

@keyframes float {
	0% {
		transform: translateY(0px);
	}
	50% {
		transform: translateY(-10px);
	}
	100% {
		transform: translateY(0px);
	}
}

.empty-message {
	font-size: 1.5rem;
	font-weight: 600;
	color: var(--gray-700);
	margin-bottom: 1.5rem;
}

.btn-outline {
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
	background-color: white;
	color: var(--primary-color);
	border: 2px solid var(--primary-color);
	border-radius: 8px;
	padding: 0.8rem 1.5rem;
	font-size: 1rem;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
}

.btn-outline:hover {
	background-color: var(--primary-color);
	color: white;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(67, 97, 238, 0.3);
}

.btn-outline:active {
	transform: translateY(0);
	box-shadow: 0 2px 5px rgba(67, 97, 238, 0.3);
}

/* 페이지네이션 */
.pagination {
	display: flex;
	justify-content: center;
	margin: 2rem 0;
	gap: 0.5rem;
}

.page-item {
	display: inline-block;
}

.page-link {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	border: 1px solid var(--gray-300);
	border-radius: 8px;
	color: var(--gray-700);
	transition: all 0.3s ease;
}

.page-link:hover {
	background-color: var(--primary-lighter);
	color: var(--primary-color);
	border-color: var(--primary-color);
}

.page-item.active .page-link {
	background-color: var(--primary-color);
	color: white;
	border-color: var(--primary-color);
	box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
}

/* 반응형 */
@media (max-width: 992px) {
	.book-list {
		grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	}
}

@media (max-width: 768px) {
	.borrowed-stats {
		flex-direction: column;
	}
	
	.book-list {
		grid-template-columns: 1fr;
	}
	
	.borrowed-subtitle {
		max-width: 100%;
	}
	
	.tab-button {
		padding: 0.8rem 1rem;
		font-size: 0.9rem;
	}
	
	.tab-content {
		padding: 1.5rem;
	}
}

@media (max-width: 576px) {
	.book-item {
		flex-direction: column;
	}
	
	.book-cover {
		width: 100%;
		height: 180px;
		margin-right: 0;
		margin-bottom: 1rem;
	}
	
	.book-cover-placeholder {
		font-size: 3rem;
	}
	
	.book-status {
		margin-left: 0;
		margin-top: 1rem;
		flex-direction: row;
		align-items: center;
		width: 100%;
	}
	
	.return-button {
		width: 100%;
		justify-content: center;
	}
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<%
	UserDTO user = (UserDTO) session.getAttribute("loginUser");
	if (user == null) {
		response.sendRedirect("/pilotpjt/loginView");
		return;
	}

	Object userBorrowedBooksObj = request.getAttribute("userBorrowedBooks"); // 유저 현재 빌린 수
	Object userBeforReturnCountObj = request.getAttribute("userRecord"); // 빌리자마자 올라가는 borrow 수
	Object userRecordCountObj = request.getAttribute("userRecordCount"); // 반납하면 올라가는 borrow 수
	int borrowingCount = 0; // 유저 현재 빌린 수
	int recordCount = 0; // 빌리자마자 올라가는 수
	int afterReturnCount = 0; // 반납하면 올라가는 수

	if (userBorrowedBooksObj != null) {
		try {
			borrowingCount = Integer.parseInt(String.valueOf(userBorrowedBooksObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userBeforReturnCountObj != null) {
		try {
			recordCount = Integer.parseInt(String.valueOf(userBeforReturnCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userRecordCountObj != null) {
		try {
			afterReturnCount = Integer.parseInt(String.valueOf(userRecordCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	// 연체 도서 수 (예시 데이터)
	int overdueCount = 0;
	%>
	<div class="container">
		<div class="borrowed-header">
			<div class="header-content">
				<h1 class="borrowed-title">
					<span class="title-icon"><i class="fas fa-book-reader"></i></span>
					<span class="title-text">내 대출 도서</span>
				</h1>
				<p class="borrowed-subtitle">현재 대출 중인 도서 목록과 반납 예정일을 확인하세요. 도서
					대출 기간은 최대 30일입니다.</p>
			</div>

			<div class="borrowed-stats">
				<div class="stat-card">
					<div class="stat-icon">
						<i class="fas fa-book"></i>
					</div>
					<div class="stat-info">
						<div class="stat-value"><%=borrowingCount%></div>
						<div class="stat-title">대출 중인 도서</div>
					</div>
				</div>

				<div class="stat-card">
					<div class="stat-icon warning">
						<i class="fas fa-exclamation-circle"></i>
					</div>
					<div class="stat-info">
						<div class="stat-value">${userOver + 2}</div>
						<div class="stat-title">연체 도서</div>
					</div>
				</div>

				<div class="stat-card">
					<div class="stat-icon success">
						<i class="fas fa-check-circle"></i>
					</div>
					<div class="stat-info">
						<div class="stat-value">${userRecord}</div>
						<div class="stat-title">총 대출 이력</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 탭 컨테이너 -->
		<div class="tab-container">
			<div class="tab-buttons">
				<button type="button" class="tab-button active" onclick="showHistoryTab('borrowed', event)">
					<i class="fas fa-book-open"></i> 대출 중인 도서
				</button>
				<button type="button" class="tab-button" onclick="showHistoryTab('returnRecord', event)">
					<i class="fas fa-history"></i> 대출 기록
				</button>
			</div>

			<!-- 대출 중인 도서 탭 -->
			<div id="borrowed" class="tab-content active">
				<%
				if (borrowingCount > 0) {
				%>
				<div class="book-list">
					<c:forEach var="book" items="${bookBorrowedList}">
						<div class="book-item">
							<div class="book-cover">
								<div class="book-cover-placeholder">
									<i class="fas fa-book"></i>
								</div>
							</div>
							<div class="book-info">
								<div class="book-title">${book.bookTitle}</div>
								<div class="book-author">${book.bookWrite}</div>
								<div class="book-dates">
									<span>대출일: ${book.bookBorrowDate}</span> 
									<span>반납예정일: ${book.bookReturnDate}</span>
								</div>
							</div>
							<div class="book-status">
								<div class="status-borrowed">대출 중</div>
								<form class="returnForm" style="margin-top: auto; width: 100%;">
									<input type="hidden" name="bookNumber" value="${book.bookNumber}">
									<button type="button" class="return-button" onclick="return_submit(this)">
										<i class="fas fa-undo-alt"></i> 반납하기
									</button>
								</form>
							</div>
						</div>
					</c:forEach>
				</div>
				<%
				} else {
				%>
				<div class="empty-state">
					<div class="empty-icon">
						<i class="fas fa-book"></i>
					</div>
					<div class="empty-message">현재 대출 중인 도서가 없습니다</div>
					<a href="book_search_view" class="btn-outline"> 
						<i class="fas fa-search"></i> 도서 검색하기
					</a>
				</div>
				<%
				}
				%>
			</div>

			<!-- 대출 기록 탭 -->
			<div id="returnRecord" class="tab-content">
				<%
				if (afterReturnCount > 0) {
				%>
				<div class="book-list">
					<c:forEach var="bookBorrowRecord" items="${bookBorrowList}">
						<div class="book-item">
							<div class="book-cover">
								<div class="book-cover-placeholder">
									<i class="fas fa-book"></i>
								</div>
							</div>
							<div class="book-info">
								<div class="book-title">${bookBorrowRecord.bookTitle}</div>
								<div class="book-author">${bookBorrowRecord.bookWrite}</div>
								<div class="book-dates">
									<span>대출일: ${bookBorrowRecord.bookBorrowDate}</span> 
									<span>반납일: ${bookBorrowRecord.bookReturnDate}</span>
								</div>
							</div>
							<div class="book-status">
								<div class="status-badge returned">
									<i class="fas fa-check-circle"></i> 반납 완료
								</div>
								<a href="/pilotpjt/book_detail?bookNumber=${bookBorrowRecord.bookNumber}" class="return-button" style="background-color: var(--secondary-color);">
									<i class="fas fa-info-circle"></i> 상세정보
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<%
				} else {
				%>
				<div class="empty-state">
					<div class="empty-icon">
						<i class="fas fa-history"></i>
					</div>
					<div class="empty-message">대출 기록이 없습니다</div>
					<a href="book_search_view" class="btn-outline"> 
						<i class="fas fa-search"></i> 도서 검색하기
					</a>
				</div>
				<%
				}
				%>
			</div>
		</div>

		<!-- 페이지네이션 -->
		<c:if test="${totalPages > 1}">
			<div class="pagination">
				<c:if test="${currentPage > 1}">
					<div class="page-item">
						<a class="page-link"
							href="?status=${param.status}&page=${currentPage - 1}"> <i
							class="fas fa-chevron-left"></i>
						</a>
					</div>
				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="pageNum">
					<div class="page-item ${pageNum == currentPage ? 'active' : ''}">
						<a class="page-link"
							href="?status=${param.status}&page=${pageNum}"> ${pageNum}
						</a>
					</div>
				</c:forEach>

				<c:if test="${currentPage < totalPages}">
					<div class="page-item">
						<a class="page-link"
							href="?status=${param.status}&page=${currentPage + 1}"> <i
							class="fas fa-chevron-right"></i>
						</a>
					</div>
				</c:if>
			</div>
		</c:if>
	</div>
</body>
</html>