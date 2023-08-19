<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="form-input" style="margin-top: 5px">
		<label for="AuthorName">Mã tác giả</label> <input id="AuthorName"
			name="authorId" value="${author.authorid}" style="width: 100%"
			required="" />
	</div>
	<div class="form-input" style="margin-top: 5px">
		<label for="AuthorName">Tên tác giả</label> <input id="AuthorName"
			name="fullName" value="${author.fullname}" style="width: 100%"
			required="" />
	</div>
	<div class="form-input">
		<label for="AuthorStory">Giới thiệu</label>
		<textarea rows="" cols="" id="story" name="story" style="width: 100%"
			; height="300px">${author.story}</textarea>
	</div>
</body>
</html>