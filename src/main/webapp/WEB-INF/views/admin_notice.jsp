<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/admin_notice.css">
<script src="/pilotpjt/resources/js/admin_notice.js"></script>
<title>공지사항 - 도서관리 시스템</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	
	<div class="container">
	    <div class="page-header">
	        <h1 class="page-title">공지사항</h1>
	        <p class="page-description">잉크트리의 중요 소식과 업데이트 정보를 확인하세요.</p>
	    </div>
	    
	    <div class="notice-stats">
	        <div class="stat-card">
	            <div class="stat-icon blue">
	                <i class="fas fa-bullhorn"></i>
	            </div>
	         
	            <div class="stat-info">
	                <div class="stat-value">${countAll}</div>
	                <div class="stat-label">전체 공지</div>
	            </div>
	        </div>
	        
	        <div class="stat-card">
	            <div class="stat-icon red">
	                <i class="fas fa-exclamation-circle"></i>
	            </div>
	            <div class="stat-info">
	                <div class="stat-value">${countImportant}</div>
	                <div class="stat-label">중요 공지</div>
	            </div>
	        </div>
	        
	        <div class="stat-card">
	            <div class="stat-icon green">
	                <i class="fas fa-calendar-alt"></i>
	            </div>
	            <div class="stat-info">
	                <div class="stat-value">${countEvent}</div>
	                <div class="stat-label">이벤트</div>
	            </div>
	        </div>
	        
	        <div class="stat-card">
	            <div class="stat-icon yellow">
	                <i class="fas fa-clock"></i>
	            </div>
	            <div class="stat-info">
	                <div class="stat-value">${countUpdate}</div>
	                <div class="stat-label">업데이트</div>
	            </div>
	        </div>
	    </div>
	    
	    <div class="notice-controls">
<!-- 	        <div class="search-filter-container"> -->
<!-- 	            <div class="search-container"> -->
<!-- 	                <form action="/pilotpjt/notice_view" method="GET"> -->
<%-- 	                    <input type="text" name="keyword" placeholder="공지사항 검색" class="search-input" value="${param.keyword}"> --%>
<!-- 	                    <button type="submit" class="search-btn"> -->
<!-- 	                        <i class="fas fa-search"></i> -->
<!-- 	                    </button> -->
<!-- 	                </form> -->
<!-- 	            </div> -->
	            
<!-- 	            <select class="filter-select" name="category" onchange="location = this.value;"> -->
<%-- 	                <option value="/pilotpjt/notice_view" ${empty param.category ? 'selected' : ''}>전체 카테고리</option> --%>
<%-- 	                <option value="/pilotpjt/notice_view?category=important" ${param.category == 'important' ? 'selected' : ''}>중요 공지</option> --%>
<%-- 	                <option value="/pilotpjt/notice_view?category=event" ${param.category == 'event' ? 'selected' : ''}>이벤트</option> --%>
<%-- 	                <option value="/pilotpjt/notice_view?category=info" ${param.category == 'info' ? 'selected' : ''}>안내</option> --%>
<%-- 	                <option value="/pilotpjt/notice_view?category=update" ${param.category == 'update' ? 'selected' : ''}>업데이트</option> --%>
<!-- 	            </select> -->
	            
<!-- 	            <select class="filter-select" name="sort" onchange="location = this.value;"> -->
<%-- 	                <option value="/pilotpjt/notice_view${not empty param.category ? '?category='.concat(param.category) : ''}" ${param.sort == null ? 'selected' : ''}>최신순</option> --%>
<%-- 	                <option value="/pilotpjt/notice_view?sort=views${not empty param.category ? '&category='.concat(param.category) : ''}" ${param.sort == 'views' ? 'selected' : ''}>조회순</option> --%>
<!-- 	            </select> -->
<!-- 	        </div> -->
	        
	        <% 
	        UserDTO user = (UserDTO) session.getAttribute("loginUser");
	        if (user != null && user.getUserAdmin() == 1) { 
	        %>
	        <a href="admin_notice_write" class="write-btn">
	            <i class="fas fa-pen"></i> 공지사항 작성
	        </a>
	        <% } %>
	    </div>
	    
	    <c:choose>
	        <c:when test="${not empty noticeList}">
	            <c:forEach items="${noticeList}" var="notice">
<%-- 	            <div class="notice-card ${notice.fixed ? 'fixed-notice' : ''}"> --%>
	                <div class="notice-card">
	                    <a href="/pilotpjt/admin_notice_detail?noticeNum=${notice.noticeNum}" class="notice-link">
	                        <div class="notice-content">
	                            <c:choose>
	                                <c:when test="${notice.noticeCategory == 'important'}">
	                                    <span class="notice-category category-important">중요 공지</span>
	                                </c:when>
	                                <c:when test="${notice.noticeCategory == 'event'}">
	                                    <span class="notice-category category-event">이벤트</span>
	                                </c:when>
	                                <c:when test="${notice.noticeCategory == 'info'}">
	                                    <span class="notice-category category-info">안내</span>
	                                </c:when>
	                                <c:when test="${notice.noticeCategory == 'update'}">
	                                    <span class="notice-category category-update">업데이트</span>
	                                </c:when>
	                            </c:choose>
	                            
	                            <h3 class="notice-title">
	                                ${notice.noticeTitle}
	                            </h3>
	                            
	                            <p class="notice-excerpt">${notice.noticeContent }</p>
	                            
	                            <div class="notice-meta">
	                                <div class="meta-left">
	                                    <div class="meta-item">
	                                        <i class="fas fa-user meta-icon"></i>
	                                        <span>${notice.noticeWriter}</span>
	                                    </div>
	                                    <div class="meta-item">
	                                        <i class="fas fa-calendar meta-icon"></i>
	                                        <span>${notice.noticeRegdate}</span>
	                                    </div>
	                                </div>
	                                <div class="meta-item">
	                                    <i class="fas fa-eye meta-icon"></i>
	                                    <span>${notice.noticeViews}</span>
	                                </div>
	                            </div>
	                        </div>
	                    </a>
	                </div>
	            </c:forEach>
	            
	            <div class="pagination">
	                <c:if test="${currentPage > 1}">
	                    <div class="page-item">
	                        <a href="/pilotpjt/notice_view?page=${currentPage - 1}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="page-link">
	                            <i class="fas fa-chevron-left"></i>
	                        </a>
	                    </div>
	                </c:if>
	                
	                <c:forEach begin="${startPage}" end="${endPage}" var="i">
	                    <div class="page-item">
	                        <a href="/pilotpjt/notice_view?page=${i}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="page-link ${currentPage == i ? 'active' : ''}">
	                            ${i}
	                        </a>
	                    </div>
	                </c:forEach>
	                
	                <c:if test="${currentPage < totalPages}">
	                    <div class="page-item">
	                        <a href="/pilotpjt/notice_view?page=${currentPage + 1}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="page-link">
	                            <i class="fas fa-chevron-right"></i>
	                        </a>
	                    </div>
	                </c:if>
	            </div>
	        </c:when>
	        <c:otherwise>
	            <div class="notice-empty">
	                <div class="empty-icon">
	                    <i class="fas fa-clipboard"></i>
	                </div>
	                <div class="empty-text">등록된 공지사항이 없습니다.</div>
	            </div>
	        </c:otherwise>
	    </c:choose>
	</div>
</body>
</html>

