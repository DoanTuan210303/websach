<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Chi tiết sản phẩm</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:wght@100;300;400;500&family=Unbounded:wght@600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/2016f2764d.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/index.css" />
<!-- . -->
<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<style>
.edit-mode {
	opacity: 1;
	pointer-events: auto;
	transition: all 0.2s linear;
}
</style>
</head>
<body>
	<div class="container">
		<%@ include file="/views/user/menu.jsp" %>
		<div class="content content-detail">
			<div class="content__best-seller content-detail content-admin">
				<div class="toggle-container">
					<div class="toggle-button" onclick="toggleContent(1)">Quản lý
						sách</div>
					<div class="toggle-button" onclick="toggleContent(2)">Quán lý
						doanh thu</div>
					<div class="toggle-button" onclick="toggleContent(3)">Thông
						tin người dùng</div>
					<div class="toggle-button" onclick="toggleContent(4)">Tài
						khoản admin</div>
					<div class="toggle-button" onclick="toggleContent(5)">Quản lý
						Loại sách</div>
					<div class="toggle-button" onclick="toggleContent(6)">Quản lý
						tác giả</div>
				</div>
				<div id="content1" class="toggle-content active-2">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Quản Lý Sách</h1>

						<form action="/admin" method="get">
							<input name="key" value="${key }" placeholder="Key?">
							<button formaction="/admin">Tìm</button>
						</form>
						<div class="pagination">
							<c:choose>
								<c:when test="${books.number == 0}">
									<a class="prev" href="/admin?p=${books.number+1 }">Next</a>
									<a class="prev" href="/admin?p=${books.totalPages-1}">Last</a>
								</c:when>
								<c:when test="${books.number == books.totalPages-1}">
									<a class="prev" href="/admin?p=0">First</a>
									<a class="prev" href="/admin?p=${books.number-1 }">Previous</a>
								</c:when>
								<c:otherwise>
									<a class="prev" href="/admin?p=0">First</a>
									<a class="prev" href="/admin?p=${books.number-1 }">Previous</a>
									<a class="prev" href="/admin?p=${books.number+1 }">Next</a>
									<a class="prev" href="/admin?p=${books.totalPages-1}">Last</a>
								</c:otherwise>
							</c:choose>
						</div>
						<table>
							<thead>
								<tr>
									<th>Hình ảnh</th>
									<th>Tiêu đề</th>
									<th>Tác giả</th>
									<th>Thể loại</th>
									<th>Giá sách</th>
									<th>Select</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${books.content }" var="book">
									<tr>
										<td style="padding: 0; text-align: center; width: 5rem"><img
											src="<%=request.getContextPath()%>/img/${book.imagebook }"
											alt="" style="width: 100%; height: auto; display: block" /></td>
										<td>${book.title }</td>
										<td>${book.author.fullname }</td>
										<td>${book.categories.namecategories }</td>
										<td>${book.price }</td>
										<td><a href="/qly-books-action/edit?id=${book.bookid }">Chọn</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<hr />
					<div class="content-admin__form">
						<h1 style="text-align: center; margin: 1rem 0">Form
							controller</h1>
						<form:form action="" method="post" modelAttribute="bookQly"
							enctype="multipart/form-data">

							<div class="form-input">
								<label for="">Mã Sách</label>
								<form:input path="bookid" id="bookid" />
								<br />
								<form:errors path="bookid" />
							</div>

							<div class="form-input">
								<label for="">Tên Sách</label>
								<form:input path="title" id="title" />
								<br />
								<form:errors path="title" />
							</div>

							<div class="form-input">
								<label for="book-category">Tác giả</label>
								<form:select path="author" id="book-author" name="book-author">
									<form:option value="0">-- Chọn tác giả --</form:option>
									<c:forEach items="${author1}" var="au">
										<form:option value="${au}">${au.fullname}</form:option>
									</c:forEach>
								</form:select>
							</div>


							<div class="form-input">
								<label for="book-category">Thể loại sách</label>
								<form:select path="categories" id="book-category"
									name="book-category">
									<form:option value="">-- Chọn thể loại --</form:option>
									<c:forEach items="${listCategory}" var="ca">
										<form:option value="${ca.categoriesid}">${ca.namecategories}</form:option>
									</c:forEach>
								</form:select>
							</div>
							<div class="form-input">
								<label for="book-category">Mô tả</label>
								<form:textarea path="describe"/>
							</div>
							<div class="form-input">
								<label for="book-image-input">Chọn hình sách:</label> <input
									type="file" id="book-image-input" name="book-image"
									accept="image/*" style="width: auto; outline: none !important" />

								<img id="book-image-preview"
									src="<%=request.getContextPath()%>/img/${bookQly.imagebook }"
									alt="Preview" />
							</div>

							<div class="form-input">
								<label for="">Giá sách</label>
								<form:input path="price" id="price" />
								<br />
								<form:errors path="price" />
							</div>
							<div class="form-button">
								<button formaction="/qly-books-action/Them">Thêm</button>
								<button formaction="/qly-books-action/Xoa">Xóa</button>
								<button formaction="/qly-books-action/Sua">Sửa</button>

							</div>

						</form:form>
						<button onclick="clearFormNam(event)">Mới</button>
					</div>
				</div>
				<div id="content2" class="toggle-content">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Thống kê doanh
							thu theo loại</h1>
						<form action="/book-info1" method="post">
							<select id="book-category" name="maloai">
								<option value="">-- Chọn thể loại --</option>
								<c:forEach var="item" items="${loai}">
									<option value="${item.categoriesid}">${item.namecategories}</option>
								</c:forEach>
							</select>
							<button>Tìm</button>
						</form>
						<table>
							<thead>
								<tr>
									<th>Hình ảnh</th>
									<th>Tên Sách</th>
									<th>Tác giả</th>
									<th>Số lượng</th>
									<th>Giá sách</th>
									<th>Tổng</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="book">
									<tr>
										<c:forEach var="book" items="${books1}">
											<tr>
												<td style="padding: 0; text-align: center; width: 5rem"><img
													src="../img/${book.imagebook}" width="100" height="150"
													style="width: 100%; height: auto; display: block"></td>
												<td>${book.title}</td>
												<td>${book.fullname}</td>
												<td>${book.quantity}</td>
												<td>${book.price}</td>
												<td>${book.tong}</td>
											</tr>
										</c:forEach>
									</tr>
								</c:forEach>
								<tr style="height: 50px">
									<td colspan="5">Tổng Tiền</td>
									<td colspan="1">${tong}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Thống kê doanh
							thu theo tháng</h1>
						<form action="/book-info2" method="post">
							<div class="select-date">
								<input type="date" name="a" /> <input type="date" name="b" />
								<button>Tìm</button>
							</div>
						</form>
						<table>
							<thead>
								<tr>
									<th>Hình ảnh</th>
									<th>Tên Sách</th>
									<th>Tác giả</th>
									<th>Số lượng</th>
									<th>Giá sách</th>
									<th>Tổng</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="book">
									<tr>
										<c:forEach var="book" items="${books2}">
											<tr>
												<td style="padding: 0; text-align: center; width: 5rem"><img
													src="../img/${book.imagebook}" width="100" height="150"
													style="width: 100%; height: auto; display: block"></td>
												<td>${book.title}</td>
												<td>${book.fullname}</td>
												<td>${book.quantity}</td>
												<td>${book.price}</td>
												<td>${book.tong}</td>
											</tr>
										</c:forEach>
									</tr>
								</c:forEach>

								<tr style="height: 50px">
									<td colspan="5">Tổng Tiền</td>
									<td colspan="1">${tong1}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="content3" class="toggle-content">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Danh sách tài
							khoản</h1>
						<table>
							<thead>
								<tr>
									<th><a href="/admin?field=username">Tên người dùng</a></th>
									<th><a href="/admin?field=fullname">Tên đầy đủ</a></th>
									<th><a href="/admin?field=email">Email</a></th>
									<th><a href="/admin?field=phone">Số điện thoại</a></th>
									<th><a href="/admin?field=position">Chức vụ</a></th>
									<th>Edit</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listUser }" var="user">
									<form action="/Qly-user-action" method="post">
										<tr>
											<td>${user.username }</td>
											<td>${user.fullname }</td>
											<td>${user.email }</td>
											<td>${user.phone }</td>
											<td>${user.position }</td>
											<td><a
												href="/Qly-user-action/remove?username=${user.username }">Delete</a></td>
										</tr>
									</form>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div id="content4" class="toggle-content">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Thông tin tài
							khoản</h1>

						<div class="content-admin__form">
							<div class="form-input">
								<label for="">Tên người dùng</label> <input type="text" name=""
									id="" />
							</div>
							<div class="form-input">
								<label for="">Tên đầy đủ</label> <input type="text" name=""
									id="" />
							</div>
							<div class="form-input">
								<label for="">Email</label> <input type="text" name="" id="" />
							</div>
							<div class="form-input">
								<label for="">Số điện thoại</label> <input type="text" name=""
									id="" />
							</div>
							<div class="form-button">
								<button>Sửa</button>
								<button>Mới</button>
							</div>
						</div>
					</div>
				</div>
				<div id="content5" class="toggle-content">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Quản lý loại
							sách</h1>
						<table>
							<thead>
								<tr>
									<th>Mã sách</th>
									<th>Loại sách</th>
									<th>Edit</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${category}" var="c">
									<tr>
										<td>${c.categoriesid}</td>
										<td>${c.namecategories}</td>
										<td><a href="/admin/edit?id=${c.categoriesid}"
											class="edit-button" onclick="editCategory(event)">Edit</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<form:form method="post" action="" modelAttribute="item">
							<div class="form-input" style="margin-top: 5px">
								<label for="categoryId">Mã sách</label>
								<form:input id="categoryId" path="categoriesid"
									style="width: 100%" />
							</div>
							<div class="form-input" style="margin-top: 5px">
								<label for="categoryName">Thể loại</label>
								<form:input id="categoryName" path="namecategories"
									style="width: 100%" autocomplete="off" />
							</div>
							<div class="form-button"
								style="width: 100%; display: flex; justify-content: center; align-items: center;">
								<button type="submit" onclick="addCategory(event)" name="action"
									class="add-button" formaction="/admin/add" value="add"
									id="addButton"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Thêm</button>
								<button type="submit" onclick="editCategory(event)"
									formaction="/admin/update" name="action" value="update"
									id="editButton"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Sửa</button>
								<button type="submit" onclick="deleteCategory(event)"
									formaction="/admin/delete" name="action" value="delete"
									id="deleteButton"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Xóa</button>
								<button type="submit" onclick="clearForm(event)" name="action"
									value="clear"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Mới</button>
							</div>
						</form:form>
					</div>
				</div>

				<div id="content6" class="toggle-content">
					<div class="content-admin__table">
						<h1 style="text-align: center; margin: 1rem 0">Quản lý tác
							giả</h1>
						<table>
							<thead>
								<tr>
									<th>Mã tác giả</th>
									<th>Tên tác giả</th>
									<th>Giới thiệu</th>
									<th>Edit</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${authorList}" var="a">
									<tr>
										<td>${a.authorid}</td>
										<td>${a.fullname}</td>
										<td>${a.story}</td>
										<td><a href="/admin/editAuthor?id=${a.authorid}">Edit</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<form method="post" action="">
							<div class="form-input" style="margin-top: 5px">
								<label for="AuthorName">Mã tác giả</label> <input
									id="AuthorName" name="authorId" value="${author.authorid}"
									style="width: 100%" required=""  />
							</div>
							<div class="form-input" style="margin-top: 5px">
								<label for="AuthorName">Tên tác giả</label> <input
									id="AuthorName" name="fullName" value="${author.fullname}"
									style="width: 100%" required="" />
							</div>
							<div class="form-input">
								<label for="AuthorStory">Giới thiệu</label>
								<textarea rows="" cols="" id="story" name="story"
									style="width: 100%; height=300px">${author.story}</textarea>
							</div>
							<div class="form-button"
								style="width: 100%; display: flex; justify-content: center; align-items: center;">
								<button class="edit-mode" type="submit" name="action"
									formaction="/admin/addAuthor" value="add" id="AuthorAddButton"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Thêm</button>
								<button class="edit-mode" type="submit"
									formaction="/admin/updateAuthor" name="action"
									value="AuthorUpdateButton" id="AuthorUpdateButton"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Sửa</button>
								<button class="edit-mode" type="submit"
									onclick="clearForm(event)" name="action" value="clear"
									style="outline: auto !important; padding: 20px; width: 5rem; margin: 1rem; transition: all 0.2s ease;">Mới</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<footer>
			<div class="footer-container">
				<div class="footer-container__info">
					<h3>Nhà Cung Cấp</h3>
					<ul>
						<li><a href="#">Đoàn Minh Tuấn(Chủ Tịch)</a></li>
						<li><a href="#">Nguyễn Thiên Phúc(Back-end)</a></li>
						<li><a href="#">Hồ Nguyễn Hoàng Vi(tester)</a></li>
						<li><a href="#">Trần Đình Khánh Đan(Back-end)</a></li>
						<li><a href="#">Nguyễn Hoài Nam(Back-end)</a></li>
						<li><a href="#">Mai Hoàng Luân(Font-end)</a></li>
					</ul>
				</div>
				<div class="footer-container__main">
					<h3>Thông Tin</h3>
					<ul>
						<li><a href="#">Copyright @1999-2020 CHUTICH.VN All
								rights Reserved.</a></li>
						<li><a href="#">Công Ty TNHH Chủ Tịch S.G (Nhà sách Chủ
								Tịch)</a></li>
						<li><a href="#">249 Đoàn Minh CHỦ TỊCH, F. Đoàn Minh
								Tuấn, Q.1, Tp. Hồ Chí Minh</a></li>
						<li><a href="#">Giấy chứng nhận đăng ký kinh doanh số:
								4102019159</a></li>
						<li><a href="#">Mã số doanh nghiệp 0303209716 - Đăng ký
								thay đổi lần 6 ngày 30/07/2010</a></li>
						<li><a href="#">Ðiện Thoại (028)39250590 - (028)39250591
								-Fax: (028)39257837</a></li>
					</ul>
				</div>
				<div class="footer-container__contact">
					<h3>Liên Hệ</h3>
					<ul>
						<li><a href="#"><i class="fa-brands fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa-solid fa-envelope"></i></a></li>
					</ul>
				</div>
			</div>
		</footer>
	</div>
	<script src="./js/script.js"></script>
	<script>
		function toggleContent(contentNumber) {
			var contentElements = document
					.getElementsByClassName("toggle-content");
			var buttonElements = document
					.getElementsByClassName("toggle-button");

			for (var i = 0; i < contentElements.length; i++) {
				if (i + 1 === contentNumber) {
					contentElements[i].classList.add("active-2");
					buttonElements[i].style.fontWeight = "bold";
				} else {
					contentElements[i].classList.remove("active-2");
					buttonElements[i].style.fontWeight = "normal";
				}
			}
		}
		// lưu toggle
		function toggleContent(contentNumber) {
			var contentElements = document
					.getElementsByClassName("toggle-content");
			var buttonElements = document
					.getElementsByClassName("toggle-button");

			for (var i = 0; i < contentElements.length; i++) {
				if (i + 1 === contentNumber) {
					contentElements[i].classList.add("active-2");
					buttonElements[i].style.fontWeight = "bold";
				} else {
					contentElements[i].classList.remove("active-2");
					buttonElements[i].style.fontWeight = "normal";
				}
			}

			// Lưu trạng thái toggle vào sessionStorage
			sessionStorage.setItem("currentToggle", contentNumber);
		}

		// Kiểm tra và áp dụng trạng thái toggle đã lưu
		window.addEventListener("DOMContentLoaded", function() {
			var currentToggle = sessionStorage.getItem("currentToggle");
			if (currentToggle) {
				toggleContent(parseInt(currentToggle));
			}
		});

		// ẩn nút:
		/* let isEditMode = false; */
		// Bỏ vô hiệu hóa input id khi trang web được tải
		/* window
		.addEventListener(
				'DOMContentLoaded',
				function() {
					document.getElementById('categoryId').disabled = false;
					document.getElementById("editButton").style.pointerEvents = "none";
					document.getElementById("deleteButton").style.pointerEvents = "none";
					document.getElementById("editButton").style.opacity = "0.5";
					document.getElementById("deleteButton").style.opacity = "0.5";
					document.getElementById("addButton").style.opacity = "1";
					document.getElementById("AuthorUpdateButton").style.pointerEvents = "none";
					document.getElementById("AuthorUpdateButton").style.opacity = "0.5";
				});
		function editCategory(event) {
			event.stopPropagation();

			document.getElementById("categoryId").style.pointerEvents = "none";
			document.getElementById("addButton").style.pointerEvents = "none";
			document.getElementById("editButton").style.pointerEvents = "auto";
			document.getElementById("deleteButton").style.pointerEvents = "auto";
			document.getElementById("categoryId").style.opacity = "0.5";
			document.getElementById("addButton").style.opacity = "0.5";
			document.getElementById("editButton").style.opacity = "1";
			document.getElementById("deleteButton").style.opacity = "1";
		} */
		function clearFormNam(event) {
			document.getElementById("bookid").value = "";
			document.getElementById("title").value = "";
			document.getElementById("price").value = "";
		}
		function clearForm(event) {
			event.preventDefault();
			document.getElementById("categoryId").value = "";
			document.getElementById("categoryName").value = "";
			document.getElementById("AuthorName").value = "";
			document.getElementById("AuthorStory").value = "";

			// Kích hoạt lại sự kiện nhấp chuột cho input
			/* 		  document.getElementById("categoryId").style.pointerEvents = "auto";
			 document.getElementById("addButton").style.pointerEvents = "auto";
			 document.getElementById("editButton").style.pointerEvents = "none";
			 document.getElementById("deleteButton").style.pointerEvents = "none";
			 document.getElementById("addButton").style.opacity = "1";
			 document.getElementById("editButton").style.opacity = "0.5";
			 document.getElementById("deleteButton").style.opacity = "0.5";
			 document.getElementById("categoryId").style.opacity = "1";
			 //isEditMode = false; */
			//isEditMode = true;
		}
		// Author
		/* 		window.addEventListener('DOMContentLoaded',function() {
		 document.getElementById("AuthorUpdateButton").style.pointerEvents = "none";
		 document.getElementById("AuthorUpdateButton").style.opacity = "0.5";
		 document.getElementById("AuthorName").style.pointerEvents = "auto";
		 document.getElementById("AuthorName").style.opacity = "1";
		 });	

		 function editAuthor(event, fullName, story) {
		 event.preventDefault();
		 document.getElementById("AuthorName").value = fullName;
		 document.getElementById("AuthorStory").value = story;

		 document.getElementById("AuthorName").style.pointerEvents = "none";
		 document.getElementById("AuthorName").style.opacity = "0.5";
		 document.getElementById("AuthorAddButton").style.pointerEvents = "none";
		 document.getElementById("AuthorAddButton").style.opacity = "0.5";
		 document.getElementById("AuthorUpdateButton").style.pointerEvents = "auto";
		 document.getElementById("AuthorUpdateButton").style.opacity = "1";
		 }

		 function clearAuthorForm(event) {
		 event.preventDefault();
		 document.getElementById("AuthorName").value = "";
		 document.getElementById("AuthorStory").value = "";
		
		 document.getElementById("AuthorName").style.pointerEvents = "auto";
		 document.getElementById("AuthorName").style.opacity = "1";
		 document.getElementById("AuthorAddButton").style.pointerEvents = "auto";
		 document.getElementById("AuthorAddButton").style.opacity = "1";
		 document.getElementById("AuthorUpdateButton").style.pointerEvents = "none";
		 document.getElementById("AuthorUpdateButton").style.opacity = "0.5";
		 } */
	</script>
</body>
</html>
