<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@page import="com.lmpjt.pilotpjt.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 - 잉크 트리</title>
    <link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/board_view.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/pilotpjt/resources/js/baord_view.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="board-container">
        <div class="board-header">
            <h1 class="board-title">게시판</h1>
            <div class="board-actions">
                <% 
                UserDTO user = (UserDTO) session.getAttribute("loginUser");
                if (user != null) { 
                %>
                <button class="write-button" onclick="location.href='/pilotpjt/board_write'">
                    <i class="fas fa-pen"></i> 글쓰기
                </button>
                <% } %>
            </div>
        </div>
        
        <div class="sort-options">
            <div class="sort-option active" onclick="changeSort('latest')">최신순</div>
            <div class="sort-option" onclick="changeSort('views')">조회순</div>
            <div class="sort-option" onclick="changeSort('likes')">추천순</div>
        </div>
        
        <form class="search-form" action="/pilotpjt/board_view" method="get">
            <select name="searchType" class="search-select">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="author">작성자</option>
            </select>
            <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요">
            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </form>
        
        <table class="board-table">
            <thead>
                <tr>
                    <th class="board-number">번호</th>
                    <th class="board-title-col">제목</th>
                    <th class="board-author">작성자</th>
                    <th class="board-date">작성일</th>
                    <th class="board-views">조회</th>
                    <th class="board-likes">추천</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="6" class="empty-message">등록된 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                
                <c:forEach items="${boardList}" var="board" varStatus="status">
                    <tr>
                        <td class="board-number">${status.count}</td>
                        <td class="board-title-col">
                            <a href="board_detail_view?boardNumber=${board.boardNumber}" class="title-link">${board.boardTitle}</a>
                        </td>
                        <td class="board-author">${board.userName}</td>
                        <td class="board-date">${board.boardWriteDate}</td>
                        <td class="board-views">${board.boardViews}</td>
                        <td class="board-likes">${board.boardLikes}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <div class="page-item">
                    <a href="/pilotpjt/board_view?page=${currentPage - 1}" class="page-link">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </div>
            </c:if>
            
            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                <div class="page-item ${pageNum == currentPage ? 'active' : ''}">
                    <a href="/pilotpjt/board_view?page=${pageNum}" class="page-link">${pageNum}</a>
                </div>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <div class="page-item">
                    <a href="/pilotpjt/board_view?page=${currentPage + 1}" class="page-link">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        function changeSort(sortType) {
            // 정렬 옵션 변경 시 처리
            const sortOptions = document.querySelectorAll('.sort-option');
            sortOptions.forEach(option => {
                option.classList.remove('active');
            });
            
            event.target.classList.add('active');
            
            // 실제 정렬 처리를 위한 AJAX 호출 또는 페이지 리로드 로직
            location.href = '/pilotpjt/board_view?sort=' + sortType;
        }
    </script>
</body>
</html>