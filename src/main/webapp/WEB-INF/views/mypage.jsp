<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
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
    <title>마이페이지 - 잉크 트리</title>
    <link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/mypage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/pilotpjt/resources/js/mypage.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <% 
    UserDTO user = (UserDTO) session.getAttribute("loginUser");
    if (user == null) {
        response.sendRedirect("/pilotpjt/loginView");
        return;
    }
    
    // 대출 중인 도서 수 (예시 데이터)
    int borrowingCount = user.getUserBorrow();
    // 연체 도서 수 (예시 데이터)
    int overdueCount = 0;
    // 대출 이력 수 (예시 데이터)
    int historyCount = 12;
    %>
    
    <div class="mypage-container">
        <div class="mypage-header">
            <h1 class="mypage-title">마이페이지</h1>
            <p class="mypage-subtitle">회원 정보 및 도서 대출 현황을 확인하실 수 있습니다.</p>
        </div>
        
        <div class="mypage-content">
            <div class="profile-sidebar">
                <div class="profile-header">
                    <div class="profile-avatar"><%= user.getUserName().substring(0, 1) %></div>
                    <div class="profile-name"><%= user.getUserName() %> 님</div>
                    <div class="profile-id"><%= user.getUserId() %></div>
                </div>
                
                <div class="profile-menu">
                    <div class="menu-item active" onclick="showTab('profile')">
                        <i class="fas fa-user"></i>
                        <span>내 정보</span>
                    </div>
                    <div class="menu-item" onclick="showTab('books')">
                        <i class="fas fa-book"></i>
                        <span>대출 현황</span>
                    </div>
                    <div class="menu-item" onclick="showTab('history')">
                        <i class="fas fa-history"></i>
                        <span>대출 이력</span>
                    </div>
                    <a href="/pilotpjt/edit_profile" class="menu-item">
                        <i class="fas fa-pen-to-square"></i>
                        <span>정보 수정</span>
                    </a>
                    <div class="menu-item" onclick="showTab('password')">
                        <i class="fas fa-lock"></i>
                        <span>비밀번호 변경</span>
                    </div>
                </div>
            </div>
            
            <div class="content-section">
                <div id="profile-tab" class="tab-content active">
                    <div class="section-header">
                        <h2 class="section-title">내 정보</h2>
                    </div>
                    
                    <div class="stats-container">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="stat-value"><%= borrowingCount %></div>
                            <div class="stat-label">대출 중인 도서</div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <div class="stat-value"><%= overdueCount %></div>
                            <div class="stat-label">연체 도서</div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-value"><%= historyCount %></div>
                            <div class="stat-label">총 대출 이력</div>
                        </div>
                    </div>
                    
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">이름</div>
                            <div class="info-value"><%= user.getUserName() %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">아이디</div>
                            <div class="info-value"><%= user.getUserId() %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">이메일</div>
                            <div class="info-value"><%= user.getUserEmail() %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">전화번호</div>
                            <div class="info-value"><%= user.getUserTel() %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">생년월일</div>
                            <div class="info-value"><%= user.getUserBirth() %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">가입일</div>
                            <div class="info-value"><%= user.getUserRegdate() %></div>
                        </div>
                    </div>
                    
                    <div class="info-item" style="grid-column: span 2;">
                        <div class="info-label">주소</div>
                        <div class="info-value">
                            <%= user.getUserZipCode() %> <%= user.getUserAddress() %> <%= user.getUserDetailAddress() %>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="/pilotpjt/edit_profile" class="btn btn-primary">
                            <i class="fas fa-pen-to-square"></i> 정보 수정
                        </a>
                    </div>
                </div>
                
                <div id="books-tab" class="tab-content">
                    <div class="section-header">
                        <h2 class="section-title">대출 현황</h2>
                    </div>
                    
                    <% if (borrowingCount > 0) { %>
                    <div class="book-list">
                        <!-- 예시 데이터: 실제로는 DB에서 가져온 데이터로 대체해야 합니다 -->
                        <div class="book-item">
                            <div class="book-cover">
                                <img src="/pilotpjt/resources/images/book_cover1.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                            </div>
                            <div class="book-info">
                                <div class="book-title">해리 포터와 마법사의 돌</div>
                                <div class="book-author">J.K. 롤링</div>
                                <div class="book-dates">
                                    <span>대출일: 2023-05-15</span>
                                    <span>반납예정일: 2023-05-29</span>
                                </div>
                            </div>
                            <div class="book-status status-borrowed">대출 중</div>
                        </div>
                        
                        <div class="book-item">
                            <div class="book-cover">
                                <img src="/pilotpjt/resources/images/book_cover2.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                            </div>
                            <div class="book-info">
                                <div class="book-title">어린 왕자</div>
                                <div class="book-author">생텍쥐페리</div>
                                <div class="book-dates">
                                    <span>대출일: 2023-05-10</span>
                                    <span>반납예정일: 2023-05-24</span>
                                </div>
                            </div>
                            <div class="book-status status-overdue">연체 (3일)</div>
                        </div>
                    </div>
                    <% } else { %>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="empty-message">현재 대출 중인 도서가 없습니다.</div>
                        <a href="/pilotpjt/book_list" class="btn btn-outline">
                            <i class="fas fa-search"></i> 도서 검색하기
                        </a>
                    </div>
                    <% } %>
                </div>
                
                <div id="history-tab" class="tab-content">
                    <div class="section-header">
                        <h2 class="section-title">대출 이력</h2>
                    </div>
                    
                    <div class="tab-container">
                        <div class="tab-buttons">
                            <button class="tab-button active" onclick="showHistoryTab('all')">전체</button>
                            <button class="tab-button" onclick="showHistoryTab('returned')">반납 완료</button>
                            <button class="tab-button" onclick="showHistoryTab('overdue')">연체 이력</button>
                        </div>
                        
                        <div id="all-history" class="tab-content active">
                            <div class="book-list">
                                <!-- 예시 데이터: 실제로는 DB에서 가져온 데이터로 대체해야 합니다 -->
                                <div class="book-item">
                                    <div class="book-cover">
                                        <img src="/pilotpjt/resources/images/book_cover3.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                                    </div>
                                    <div class="book-info">
                                        <div class="book-title">데미안</div>
                                        <div class="book-author">헤르만 헤세</div>
                                        <div class="book-dates">
                                            <span>대출일: 2023-04-15</span>
                                            <span>반납일: 2023-04-28</span>
                                        </div>
                                    </div>
                                    <div class="book-status status-returned">반납 완료</div>
                                </div>
                                
                                <div class="book-item">
                                    <div class="book-cover">
                                        <img src="/pilotpjt/resources/images/book_cover4.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                                    </div>
                                    <div class="book-info">
                                        <div class="book-title">1984</div>
                                        <div class="book-author">조지 오웰</div>
                                        <div class="book-dates">
                                            <span>대출일: 2023-03-20</span>
                                            <span>반납일: 2023-04-05</span>
                                        </div>
                                    </div>
                                    <div class="book-status status-overdue">연체 반납 (2일)</div>
                                </div>
                            </div>
                        </div>
                        
                        <div id="returned-history" class="tab-content">
                            <div class="book-list">
                                <div class="book-item">
                                    <div class="book-cover">
                                        <img src="/pilotpjt/resources/images/book_cover3.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                                    </div>
                                    <div class="book-info">
                                        <div class="book-title">데미안</div>
                                        <div class="book-author">헤르만 헤세</div>
                                        <div class="book-dates">
                                            <span>대출일: 2023-04-15</span>
                                            <span>반납일: 2023-04-28</span>
                                        </div>
                                    </div>
                                    <div class="book-status status-returned">반납 완료</div>
                                </div>
                            </div>
                        </div>
                        
                        <div id="overdue-history" class="tab-content">
                            <div class="book-list">
                                <div class="book-item">
                                    <div class="book-cover">
                                        <img src="/pilotpjt/resources/images/book_cover4.jpg" alt="책 표지" onerror="this.src='/pilotpjt/resources/images/default-book.png'">
                                    </div>
                                    <div class="book-info">
                                        <div class="book-title">1984</div>
                                        <div class="book-author">조지 오웰</div>
                                        <div class="book-dates">
                                            <span>대출일: 2023-03-20</span>
                                            <span>반납일: 2023-04-05</span>
                                        </div>
                                    </div>
                                    <div class="book-status status-overdue">연체 반납 (2일)</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="password-tab" class="tab-content">
                    <div class="section-header">
                        <h2 class="section-title">비밀번호 변경</h2>
                    </div>
                    
                    <form action="/pilotpjt/change_password" method="post" onsubmit="return validatePasswordForm()">
                        <div class="info-grid" style="grid-template-columns: 1fr;">
                            <div class="info-item">
                                <div class="info-label">현재 비밀번호</div>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-input" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;" required>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">새 비밀번호</div>
                                <input type="password" id="newPassword" name="newPassword" class="form-input" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;" required>
                                <div class="info-label" style="margin-top: 5px; font-size: 12px; color: #999;">
                                    * 8자 이상, 영문, 숫자, 특수문자 조합
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">새 비밀번호 확인</div>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;" required>
                                <div id="passwordError" style="color: #f44336; font-size: 13px; margin-top: 5px;"></div>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check"></i> 비밀번호 변경
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>