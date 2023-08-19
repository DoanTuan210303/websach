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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" />
<!-- . -->
<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
</head>
<body>
	<div class="container">
		<%@ include file="menu.jsp" %>
		<div class="content content-detail">
			<div class="content-filter after-toggle">
				<ul>
					<h2>
						<a href="/books">Loại Sách</a>
					</h2>
					<c:forEach items="${categoryItems}" var="ca">
						<li><a href="/books1?categoryName=${ca.namecategories}">${ca.namecategories }</a>
						</li>
					</c:forEach>
				</ul>
				<button class="filter-toggle-button">
					<i class="fas fa-arrow-left"></i>
				</button>
			</div>
			<div class="content__best-seller content-detail">
				<h4>
					<strong>Sách bán chạy</strong>
				</h4>
				<div class="best-seller__product detail-product">

					<c:forEach items="${page.content}" var="bo">
						<div class="product-item">
							<div class="product">
								<a href="/book-details?id=${bo.bookid}" class="product-link"> <img
									src="../sach/${bo.imagebook }" alt="book1"
									class="product-image" />
								</a> <span class="product-name"><a class="cart-button"
									href="../main/cart.html">Add to cart</a></span>
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="pagination">
					<c:if test="${page.number > 0}">
						<c:choose>
							<c:when test="${empty param.categoryName &&  empty param.keyword}">
								<a class="prev" href="/books1?p=0">First</a>
								<a class="prev" href="/books1?p=${page.number-1}">Previous</a>
							</c:when>
							<c:when test="${not empty param.keyword}">
								<a class="prev" href="/books?p=0&keyword=${param.keyword}">First</a>
								<a class="prev" href="/books?p=${page.number-1}&keyword=${param.keyword}">Previous</a>
							</c:when>
							<c:otherwise>
								<a class="prev"
									href="/books1?p=0&categoryName=${param.categoryName}">First</a>
								<a class="prev"
									href="/books1?p=${page.number-1}&categoryName=${param.categoryName}">Previous</a>
							</c:otherwise>
						</c:choose>
					</c:if>

					<c:if test="${page.number < page.totalPages-1}">
						<c:choose>
							<c:when test="${empty param.categoryName &&  empty param.keyword }">
								<a class="prev" href="/books1?p=${page.number+1}">Next</a>
								<a class="next" href="/books1?p=${page.totalPages-1}">Last</a>
							</c:when>
							<c:when test="${not empty param.keyword}">
								<a class="prev" href="/books?p=${page.number+1}&keyword=${param.keyword}">Next</a>
								<a class="next" href="/books?p=${page.totalPages-1}&keyword=${param.keyword}">Last</a>
							</c:when>
							<c:otherwise>
								<a class="prev"
									href="/books1?p=${page.number+1}&categoryName=${param.categoryName}">Next</a>
								<a class="next"
									href="/books1?p=${page.totalPages-1}&categoryName=${param.categoryName}">Last</a>
							</c:otherwise>
						</c:choose>
					</c:if>
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
</body>
<script src="../js/script.js"></script>
</html>