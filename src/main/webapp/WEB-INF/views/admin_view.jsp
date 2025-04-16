<%@page import="com.lmpjt.pilotpjt.dto.BoardDTO"%>
<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>�������� �ý��� - ������ ��ú���</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/admin_view.css">
</head>

<body>
	<%
	UserDTO user = (UserDTO) session.getAttribute("loginUser");
	BoardDTO board = (BoardDTO) request.getAttribute("board");
	%>
	<jsp:include page="header.jsp" />
	<div class="container">
		<!-- Sidebar -->
		<aside class="sidebar">
			<div class="sidebar-header">
				<h1>�������� �ý���</h1>
				<p>������ ��ú���</p>
			</div>

			<div class="admin-info">
				<div class="admin-avatar">
					<i class="ri-user-line"></i>
				</div>
				<div class="admin-details">
					<h3>
						������<%=user.getUserName()%></h3>
					<p><%=user.getUserEmail()%></p>
				</div>
			</div>

			<nav class="nav-menu">
				<div class="menu-category">��ú���</div>
				<ul class="nav-list">
					<li class="nav-item"><a href="admin_dashboard"
						class="nav-link active"> <i class="ri-dashboard-line"></i> <span>��ú���</span>
					</a></li>
				</ul>

				<div class="menu-category">���� ����</div>
				<ul class="nav-list">
					<li class="nav-item"><a href="book_insert_view"
						class="nav-link"> <i class="ri-file-add-line"></i> <span>����
								���</span>
					</a></li>
					<li class="nav-item"><a href="book_manage" class="nav-link">
							<i class="ri-book-line"></i> <span>���� ����</span>
					</a></li>
					<li class="nav-item"><a href="book_category" class="nav-link">
							<i class="ri-bookmark-line"></i> <span>ī�װ� ����</span>
					</a></li>
				</ul>

				<div class="menu-category">ȸ�� ����</div>
				<ul class="nav-list">
					<li class="nav-item"><a href="user_manage" class="nav-link">
							<i class="ri-user-settings-line"></i> <span>ȸ�� ����</span>
					</a></li>
					<li class="nav-item"><a href="user_borrow" class="nav-link">
							<i class="ri-file-list-3-line"></i> <span>����/�ݳ� ����</span>
					</a></li>
				</ul>

				<div class="menu-category">������ ����</div>
				<ul class="nav-list">
					<li class="nav-item"><a href="admin_notice_write"
						class="nav-link"> <i class="ri-notification-line"></i> <span>��������
								���</span>
					</a></li>
					<li class="nav-item"><a href="notice_manage" class="nav-link">
							<i class="ri-file-list-line"></i> <span>�������� ����</span>
					</a></li>
					<!--                     <li class="nav-item"> -->
					<!--                         <a href="event_manage" class="nav-link"> -->
					<!--                             <i class="ri-calendar-event-line"></i> -->
					<!--                             <span>�̺�Ʈ ����</span> -->
					<!--                         </a> -->
					<!--                     </li> -->
				</ul>

				<!--                 <div class="menu-category">�ý���</div> -->
				<!--                 <ul class="nav-list"> -->
				<!--                     <li class="nav-item"> -->
				<!--                         <a href="settings" class="nav-link"> -->
				<!--                             <i class="ri-settings-line"></i> -->
				<!--                             <span>ȯ�漳��</span> -->
				<!--                         </a> -->
				<!--                     </li> -->
				<!--                     <li class="nav-item"> -->
				<!--                         <a href="logout" class="nav-link"> -->
				<!--                             <i class="ri-logout-box-line"></i> -->
				<!--                             <span>�α׾ƿ�</span> -->
				<!--                         </a> -->
				<!--                     </li> -->
				</ul>
			</nav>
		</aside>

		<!-- Main Content -->
		<main class="main-content">
			<div class="page-header">
				<div class="page-title">
					<h2>������ ��ú���</h2>
				</div>
				<div class="header-actions">
					<a href="reports" class="btn btn-outline">���� ����</a> <a
						href="settings" class="btn">ȯ�漳��</a>
				</div>
			</div>

			<div class="dashboard-stats">
				<div class="stat-card">
					<div class="stat-icon books">
						<i class="ri-book-open-line"></i>
					</div>
					<div class="stat-details">
						<h3>��ü ����</h3>
						<div class="number"><fmt:formatNumber value="${totalBooks}" type="number"/></div>
					</div>
				</div>

				<div class="stat-card">
					<div class="stat-icon users">
						<i class="ri-user-line"></i>
					</div>
					<div class="stat-details">
						<h3>��ü ȸ��</h3>
						<div class="number"><fmt:formatNumber value="${totalUsers}" type="number"/></div>
					</div>
				</div>

				<div class="stat-card">
					<div class="stat-icon borrowed">
						<i class="ri-bookmark-line"></i>
					</div>
					<div class="stat-details">
						<h3>���� ���� ����</h3>
						<div class="number"><fmt:formatNumber value="${borrowedBooks}" type="number"/></div>
					</div>
				</div>

				<div class="stat-card">
					<div class="stat-icon overdue">
						<i class="ri-alarm-warning-line"></i>
					</div>
					<div class="stat-details">
						<h3>��ü ����</h3>
						<div class="number"><fmt:formatNumber value="${overdueBooks}" type="number"/></div>
					</div>
				</div>
			</div>


			<!-- Quick Actions -->
			<div class="quick-actions">
				<div class="action-card">
					<div class="action-icon">
						<i class="ri-file-add-line"></i>
					</div>
					<h3>���� ���</h3>
					<p>���ο� ������ �ý��ۿ� ����մϴ�.</p>
					<a href="book_insert_view">����ϱ�</a>
				</div>

				<div class="action-card">
					<div class="action-icon">
						<i class="ri-user-settings-line"></i>
					</div>
					<h3>ȸ�� ����</h3>
					<p>ȸ�� ������ ��ȸ�ϰ� �����մϴ�.</p>
					<a href="user_manage">�����ϱ�</a>
				</div>

				<div class="action-card">
					<div class="action-icon">
						<i class="ri-notification-line"></i>
					</div>
					<h3>�������� ���</h3>
					<p>���ο� ���������� ����մϴ�.</p>
					<a href="admin_notice_write">����ϱ�</a>
				</div>

				<div class="action-card">
					<div class="action-icon">
						<i class="ri-file-list-3-line"></i>
					</div>
					<h3>����/�ݳ� ����</h3>
					<p>���� ���� �� �ݳ��� �����մϴ�.</p>
					<a href="user_borrow">�����ϱ�</a>
				</div>
			</div>

			<!-- Recent Activity -->
			<div class="recent-activity">
				<div class="section-header">
					<h3>�ֱ� Ȱ��</h3>
					<a href="activity_log" class="view-all">��ü����</a>
				</div>

				<ul class="activity-list">
					<li class="activity-item">
						<div class="activity-icon">
							<i class="ri-book-add-line"></i>
						</div>
						<div class="activity-details">
							<h4>�� ���� ���</h4>
							<p>"Ŭ�� �ڵ�" ������ ��ϵǾ����ϴ�.</p>
							<span class="activity-time">���� 14:25</span>
						</div>
					</li>

					<li class="activity-item">
						<div class="activity-icon">
							<i class="ri-user-add-line"></i>
						</div>
						<div class="activity-details">
							<h4>�� ȸ�� ����</h4>
							<p>��ö�� ȸ���� �����߽��ϴ�.</p>
							<span class="activity-time">���� 11:30</span>
						</div>
					</li>

					<li class="activity-item">
						<div class="activity-icon">
							<i class="ri-bookmark-line"></i>
						</div>
						<div class="activity-details">
							<h4>���� ����</h4>
							<p>�̿��� ȸ���� "�ڹ��� ����" ������ �����߽��ϴ�.</p>
							<span class="activity-time">���� 10:15</span>
						</div>
					</li>

					<li class="activity-item">
						<div class="activity-icon">
							<i class="ri-notification-line"></i>
						</div>
						<div class="activity-details">
							<h4>�������� ���</h4>
							<p>"������ �ް� �ȳ�" ���������� ��ϵǾ����ϴ�.</p>
							<span class="activity-time">���� 16:40</span>
						</div>
					</li>

					<li class="activity-item">
						<div class="activity-icon">
							<i class="ri-book-read-line"></i>
						</div>
						<div class="activity-details">
							<h4>���� �ݳ�</h4>
							<p>������ ȸ���� "�����ͺ��̽� ����" ������ �ݳ��߽��ϴ�.</p>
							<span class="activity-time">���� 15:20</span>
						</div>
					</li>
				</ul>
			</div>

		</main>
	</div>
</body>
</html>