<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.lmpjt.pilotpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성 - 잉크 트리</title>
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/board_write.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
<script src="/pilotpjt/resources/js/baord_write.js"></script>

</head>
<body>
	<jsp:include page="header.jsp" />

	<%
	UserDTO user = (UserDTO) session.getAttribute("loginUser");
	if (user == null) {
		response.sendRedirect("loginView");
		return;
	}
	%>

	<div class="board-container">
		<div class="board-form">
			<div class="form-header">
				<h1 class="form-title">게시글 작성</h1>
				<p class="form-description">자유롭게 의견을 나누고 소통해보세요.</p>
			</div>

			<!-- 			<form id="frm" onsubmit="return validateForm()"> -->
			<form id="frm">
				<input type="hidden" name="userNumber"
					value="<%=user.getUserNumber()%>"> <input type="hidden"
					name="userName" value="<%=user.getUserName()%>">
				<!-- 					<input type="hidden" name="boardContent" id="boardContent"> -->

				<div class="form-group">
					<label for="boardTitle" class="form-label">제목</label> <input
						type="text" id="boardTitle" name="boardTitle" class="form-control"
						placeholder="제목을 입력하세요" required>
				</div>

				<div class="form-group">
					<label for="editor" class="form-label">내용</label>
					<input type="hidden" name="boardContent" id="boardContent">
					<div id="editor" class="editor-container" name="boardContent"></div>
					<div id="contentError" class="error-message"></div>
				</div>

				<div class="form-actions">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='board_view'">취소</button>
					<button type="button" class="btn btn-primary" onclick="fn_submit()">등록하기</button>
				</div>
			</form>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script type="text/javascript">
		function fn_submit() {
			const content = quill.root.innerHTML;
			const plainText = quill.getText().trim();

			// 유효성 검사
			if (plainText.length < 1) {
				document.getElementById('contentError').textContent = '내용은 최소 10자 이상 입력해주세요.';
				return;
			} else {
				document.getElementById('contentError').textContent = '';
			}

			document.getElementById('boardContent').value = content;

			var formData = $("#frm").serialize();

			$.ajax({
				type : "post",
				url : "board_write_ok",
				data : formData,
				success : function(data) {
					alert("저장완료");
					location.href = "board_view";
				},
				error : function() {
					alert("오류발생");
				}
			});
		}
		// Quill 에디터 초기화
		var quill = new Quill('#editor', {
			theme : 'snow',
			placeholder : '내용을 입력하세요.',
			modules : {
				toolbar : [ [ {
					'header' : [ 1, 2, 3, 4, 5, 6, false ]
				} ], [ 'bold', 'italic', 'underline', 'strike' ], [ {
					'color' : []
				}, {
					'background' : []
				} ], [ {
					'list' : 'ordered'
				}, {
					'list' : 'bullet'
				} ], [ {
					'align' : []
				} ], [ 'link', 'image' ], [ 'clean' ] ]
			}
		});
	</script>

</body>
</html>