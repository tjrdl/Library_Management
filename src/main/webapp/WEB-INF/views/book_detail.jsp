<%@page import="com.lmpjt.pilotpjt.dto.BookDTO"%>
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
<title>${book.bookTitle}-도서상세정보- 잉크 트리</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/book_detail.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
	function fn_submit() {
		const form = document.getElementById("frm");

		if (!form.checkValidity()) {
			form.reportValidity();
			return;
		}

		const formData = $("#frm").serialize();

		$.ajax({
			type : "post",
			url : "book_borrow",
			data : formData,
			success : function(responseText) {
				// 성공 처리
				if (responseText === "successBorrow") {
					alert("도서 대출이 성공적으로 완료되었습니다!");
					location.href = "book_detail?bookNumber="
							+ $("#bookNumber").val();
				} else {
					alert("알 수 없는 응답: " + responseText);
				}
			},
			error : function(xhr) {
				const msg = xhr.responseText;
				switch (msg) {
				case "noUser":
					alert("로그인이 필요합니다.");
					break;
				case "userInfoError":
					alert("회원 정보가 올바르지 않아 대출에 실패했습니다.");
					break;
				case "userCanBorrowOver":
					alert("대출 가능 권수를 초과했습니다.");
					break;
				case "alreadyBorrow":
					alert("이미 빌린 책입니다.");
					break;
				case "serverError":
				case "unexpectedServerError":
					alert("서버 오류가 발생했습니다.");
					break;
				default:
					alert("알 수 없는 오류: " + msg);
				}
			}
		});
	}
</script>

<script type="text/javascript">
function fn_del() {
	const form = document.getElementById("frm_del");

	if (!form.checkValidity()) {
		form.reportValidity();
		return;
	}

	const formData = $("#frm_del").serialize();

	$.ajax({
		type : "post",
		url : "book_delete",
		data : formData,
		success : function(responseText) {
			// 성공 처리
			if (responseText === "successDelete") {
				alert("도서가 성공적으로 삭제되었습니다!");
				location.href = "book_search_view?searchKeyword=&searchType=title&majorCategory=&subCategory=";
			} else {
				alert("책 삭제 실패: " + responseText);
			}
		},
		error : function(xhr) {
			const msg = xhr.responseText;
			switch (msg) {
			case "noUser":
				alert("로그인이 필요합니다.");
				break;
			case "serverError":
			case "unexpectedServerError":
				alert("서버 오류가 발생했습니다.");
				break;
			default:
				alert("알 수 없는 오류: " + msg);
			}
		}
	});
}
</script>


</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="book-detail-container">
			<div class="book-detail-header">
				<h1 class="book-detail-title">
					<i class="fas fa-book"></i> 도서 상세 정보
				</h1>
			</div>

			<div class="book-detail-content">
				<div class="book-image-section">
					<div class="book-cover">
						<!-- 실제 구현 시 도서 이미지 경로를 사용해야함 -->
						<!-- <img src="/pilotpjt/resources/images/books/${book.bookNumber}.jpg" alt="${book.bookTitle}" 
                            onerror="this.style.display='none'; document.getElementById('placeholder-${book.bookNumber}').style.display='flex';"> -->
						<div class="book-cover-placeholder"
							id="placeholder-${book.bookNumber}">
							<i class="fas fa-book"></i>
						</div>
					</div>
				</div>

				<div class="book-info-section">
					<div class="book-info-main">
						<h2 class="book-title">${book.bookTitle}</h2>

						<div class="book-meta">
							<div class="book-meta-item">
								<span class="meta-label">저자</span> <span class="meta-value">${book.bookWrite}</span>
							</div>
							<div class="book-meta-item">
								<span class="meta-label">출판사</span> <span class="meta-value">${book.bookPub}</span>
							</div>
							<div class="book-meta-item">
								<span class="meta-label">출판일</span> <span class="meta-value">
									<fmt:formatDate value="${book.bookDate}"
										pattern="yyyy년 MM월 dd일" />
								</span>
							</div>
							<div class="book-meta-item">
								<span class="meta-label">ISBN</span> <span class="meta-value">${book.bookIsbn}</span>
							</div>
						</div>

						<div class="book-categories">
							<span class="book-category">${book.bookMajorCategory}</span>
							<c:if test="${not empty book.bookSubCategory}">
								<span class="book-category">${book.bookSubCategory}</span>
							</c:if>
						</div>

						<div class="book-status">
							<div
								class="book-availability ${book.bookCount > 0 ? 'available' : 'unavailable'}">
								<c:choose>
									<c:when test="${book.bookCount > 0}">
										<i class="fas fa-check-circle"></i> 대출 가능
                                    </c:when>
									<c:otherwise>
										<i class="fas fa-times-circle"></i> 대출 불가
                                    </c:otherwise>
								</c:choose>
							</div>
							<div class="book-count">
								<i class="fas fa-book"></i> 보유 수량: ${book.bookCount}권
							</div>
							<div class="book-count">
								<i class="fas fa-chart-line"></i> 대출 횟수:
								${book.bookBorrowcount}회
							</div>
								<%
								UserDTO user = (UserDTO) session.getAttribute("loginUser");
								BookDTO book = (BookDTO) request.getAttribute("book");
			
								if (user != null && user.getUserAdmin() == 1) {
								%>
								<button class="action-button edit-button"
									onclick="location.href='/pilotpjt/update_book?bookNumber=${book.bookNumber}'">
									<i class="fas fa-edit"></i> 수정
								</button>
								<form id ="frm_del">
								<input type="hidden" name="bookNumber" id="bookNumber" value="${book.bookNumber}">
								<button class="action-button delete-button"
									onclick="fn_del(${book.bookNumber})">
									<i class="fas fa-trash"></i> 삭제
								</button>
								</form>
								<%
								}
								%>
						</div>

						<div class="book-actions">
							<form id="frm">
							<input type="hidden" name="bookNumber" id="bookNumber" value="${book.bookNumber}">
								<c:choose>
									<c:when test="${book.bookCount > 0}">
										<%-- 	<a href="book_borrow?bookNumber=${book.bookNumber}" --%>
										<!-- 	class="book-action-button borrow-button"> <i -->
										<!-- 	class="fas fa-hand-holding"></i> 대출하기 -->
										<!-- 	</a> -->
										<input type="button" value="대출하기" onclick="fn_submit()">
									</c:when>
									<c:otherwise>
										<button class="book-action-button borrow-button" disabled>
											<i class="fas fa-hand-holding"></i> 대출 불가
										</button>
									</c:otherwise>
								</c:choose>
<%-- 								<a href="/pilotpjt/add_wishlist?bookNumber=${book.bookNumber}" --%>
<!-- 									class="book-action-button wishlist-button"> <i -->
<!-- 									class="fas fa-heart"></i> 위시리스트에 추가 -->
								<a href=""
									class="book-action-button wishlist-button"> <i
									class="fas fa-heart"></i> 위시리스트에 추가
								</a> <a href="javascript:history.back()"
									class="book-action-button back-button"> <i
									class="fas fa-arrow-left"></i> 목록으로 돌아가기
								</a>
							</form>
						</div>
					</div>

					<div class="book-description-section">
						<h3 class="section-title">도서 소개</h3>
						<div class="book-description">
							<p>${book.bookComent}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 관련 도서 섹션 (선택적) -->
		<c:if test="${not empty relatedBooks}">
			<div class="related-books-section">
				<h3 class="section-title">관련 도서</h3>
				<div class="related-books-grid">
					<c:forEach items="${relatedBooks}" var="relatedBook">
						<div class="related-book-card">
							<div class="related-book-cover">
								<i class="fas fa-book"></i>
							</div>
							<div class="related-book-info">
								<h4 class="related-book-title">${relatedBook.bookTitle}</h4>
								<div class="related-book-author">${relatedBook.bookWrite}</div>
								<a
									href="/pilotpjt/book_detail?bookNumber=${relatedBook.bookNumber}"
									class="related-book-link">상세보기</a>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>
	<!-- 대출 불가 사유 alert 후 location을 통해 다시 book_detail 페이지로 전환됨 -->
	<c:if test="${not empty errorMsg}">
		<script>
			alert("${errorMsg}");
			window.location.href = "book_detail?bookNumber=${bookNumber}";
		</script>
	</c:if>
	<!-- 대출 완료 alert 후 book_detail 페이지 전환 -->
	<c:if test="${not empty successMSG}">
		<script>
			alert("${successMSG}");
			window.location.href = "book_detail?bookNumber=${bookNumber}";
		</script>
	</c:if>
</body>
</html>