<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 등록</title>
<link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/book_insert.css">
<script src="/pilotpjt/resources/js/book_insert.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
	function fn_submit() {
		var formData = $("#frm").serialize();//form 요소 자체

		//비동기 전송방식의 jquery 함수
		$.ajax({
			type : "post",
			data : formData,
			url : "book_insert",
			success : function(data) {
				alert("저장완료");
				location.href="admin_view"
			},
			error : function() {
				alert("오류발생");
			}
		});
	}
</script>
</head>
<body>
<%
// 	카테고리 부분 인코딩이 깨짐;;;
	request.setCharacterEncoding("utf-8");
%>
   
<!--    <form method="post" action="book_insert"> -->
   <form id="frm">
      <label>
         제목<input type="text" name="bookTitle" required placeholder="도서 제목을 입력하세요">
      </label>
      <br>
      <label>
         내용<input type="text" name="bookComent" required placeholder="책의 간략한 내용을 입력하세요">
      </label>
      <br>
      <label>
         작가<input type="text" name="bookWrite" required placeholder="작가 이름을 입력하세요">
      </label>
      <br>
      <label>
         출판사<input type="text" name="bookPub" required placeholder="출판사 이름을 입력하세요">
      </label>
      <br>
      <label>
         발행일<input type="date" name="bookDate" required>
      </label>
      <br>
      <!-- 대분류 선택 -->
      <label>
         카테고리(대분류)
         <select id="mainCategory" name="bookMajorCategory" required onchange="updateSubCategories()">
            <option value="">선택하세요</option>
            <option value="소설">소설</option>
            <option value="과학">과학</option>
            <option value="인문">인문</option>
            <option value="기술">기술</option>
            <option value="기타">기타</option>
         </select>
      </label>
      <br>

      <!-- 소분류 선택 -->
      <label>
         카테고리(소분류)
         <select id="subCategory" name="bookSubCategory" required>
            <option value="">소분류를 선택하세요</option>
         </select>
      </label>
      <br>
      <label>
         재고<input type="number" name="bookCount" required min="1" placeholder="보유 재고 수량을 입력하세요">
      </label>
      <br>
<!--       <input type="submit" value="등록"> -->
      <input type="button" value="등록" onclick="fn_submit()">
   </form>
</body>
</html>
