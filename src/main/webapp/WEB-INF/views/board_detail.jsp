<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@page import="com.lmpjt.pilotpjt.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${board.boardTitle} - 잉크 트리</title>
    <link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/board_detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/pilotpjt/resources/js/baord_detail.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="board-container">
        <div class="board-detail">
            <div class="board-header">
                <h1 class="board-title">${board.boardTitle}</h1>
                <div class="board-meta">
                    <div class="author-info">
                    
                        <div class="author-avatar">${board.userName.substring(0,1)}</div>
                        <div>
                            <div>${board.userName}</div>
                            <div>${board.boardWriteDate}</div>
                        </div>
                    </div>
                    <div class="post-info">
                        <div class="info-item">
                            <i class="fas fa-eye"></i>
                            <span>${board.boardViews}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-heart"></i>
                            <span>${board.boardLikes}</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="board-content">
                ${board.boardContent}
            </div>
            
            <div class="board-actions">
                <button class="like-button" onclick="likePost(${board.boardNumber})">
                    <i class="fas fa-heart"></i>
                    <span>추천</span>
                    <span class="like-count">${board.boardLikes}</span>
                </button>
                
                <div class="action-buttons">
                    <% 
                    UserDTO user = (UserDTO) session.getAttribute("loginUser");
                    BoardDTO board = (BoardDTO) request.getAttribute("board");
                    
                    if (user != null && (user.getUserNumber() == board.getUserNumber() || user.getUserAdmin() == 1)) { 
                    %>
                    <button class="action-button edit-button" onclick="location.href='/pilotpjt/board_edit?boardNumber=${board.boardNumber}'">
                        <i class="fas fa-edit"></i> 수정
                    </button>
                    <button class="action-button delete-button" onclick="deletePost(${board.boardNumber})">
                        <i class="fas fa-trash"></i> 삭제
                    </button>
                    <% } %>
                    <button class="action-button list-button" onclick="location.href='/pilotpjt/board_view'">
                        <i class="fas fa-list"></i> 목록
                    </button>
                </div>
            </div>
        </div>
        
        <div class="comments-section">
            <h2 class="comments-header">댓글</h2>
            
            <% if (user != null) { %>
            <div class="comment-form">
                <form action="/pilotpjt/add_comment" method="post">
                    <input type="hidden" name="boardNumber" value="${board.boardNumber}">
                    <textarea name="commentContent" class="comment-textarea" placeholder="댓글을 작성해주세요"></textarea>
                    <button type="submit" class="comment-submit">댓글 작성</button>
                    <div style="clear: both;"></div>
                </form>
            </div>
            <% } else { %>
            <div class="comment-form">
                <p style="text-align: center; color: #888;">댓글을 작성하려면 <a href="/pilotpjt/loginView" style="color: var(--primary-color);">로그인</a>이 필요합니다.</p>
            </div>
            <% } %>
            
            <div class="comment-list">
                <c:if test="${empty commentList}">
                    <div class="no-comments">
                        <p>아직 댓글이 없습니다. 첫 댓글을 작성해보세요!</p>
                    </div>
                </c:if>
                
                <c:forEach items="${commentList}" var="comment">
                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author">${comment.userName}</div>
                            <div class="comment-date">${comment.commentDate}</div>
                        </div>
                        <div class="comment-content">${comment.commentContent}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <script>
    function likePost(boardNumber) {
        $.ajax({
            type: "post",
            url: "/pilotpjt/boardLikes",
            data: { boardNumber: boardNumber },
            success: function(data) {
                let likeCountElement = $(".like-count");
                let currentCount = parseInt(likeCountElement.text());
                likeCountElement.text(currentCount + 1);

                console.log(data); 
            },
            error: function(xhr) {
                if (xhr.status === 409) {
                    alert("이미 추천을 눌렀습니다.");
                } else if (xhr.status === 401) {
                    alert("로그인 후 추천을 누르실 수 있습니다.");
                } else {
                    alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                }
            }
        });
    }

        
        function deletePost(boardNumber) {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                location.href = '/pilotpjt/delete_post?boardNumber=' + boardNumber;
            }
        }
    </script>
</body>
</html>