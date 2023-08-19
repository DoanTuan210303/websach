<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Trang Chủ</title>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/lp.css">
<style>
input {
	outline: auto !important;
}

input:focus {
	outline: auto !important;
}

.enter-name {
	pointer-events: none;
	opacity: 0.5;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<c:choose>
				<c:when
					test="${sessionScope.user != null && sessionScope.user.position==true}">
					<a href="/admin"> <img class="header__logo"
						src="<%=request.getContextPath()%>/img/logo2.png" alt="logo_web" />
					</a>
				</c:when>
				<c:otherwise>
					<a href="#"> <img class="header__logo" src="<%=request.getContextPath()%>/img/logo2.png"
						alt="logo_web" />
					</a>
				</c:otherwise>
			</c:choose>

			<div style="border-left: 1px solid rgb(126, 117, 117)"></div>
			<!--  -->
			<div class="header__menu">
				<div class="header__menu-container">
					<div class="header__user-container">
						<a href="/user/index">
							<div class="header__menu-item--home">
								<i class="fa-solid fa-house"></i>
								<h5>Trang chủ</h5>
							</div>
						</a> <a href="/books">
							<div class="header__menu-item--detail">
								<i class="fa-solid fa-shop"></i>
								<h5>Chi tiết</h5>
							</div>
						</a> <a href="/user/cart">
							<div class="header__menu-item--cart">
								<i class="fa-sharp fa-solid fa-cart-shopping"> </i>
								<h5>Giỏ hàng</h5>
							</div>
						</a> <a href="/user/sign-in">
							<div class="header__menu-item--user">

								<c:choose>
									<c:when
										test="${sessionScope.user != null && sessionScope.user.position==false}">
										<a href="/user/info">
											<div class="header__menu-item--user">
												<i class="fa-solid fa-user"></i>
												<h5>${sessionScope.user.fullname}</h5>
											</div>
										</a>
									</c:when>
									<c:when test="${sessionScope.user != null}">
										<!-- Xử lý khi entity tồn tại trong session -->
										<a href="./user-info.html">
											<div class="header__menu-item--user">
												<i class="fa-solid fa-user"></i>
												<h5>${sessionScope.user.fullname}</h5>
											</div>
										</a>
									</c:when>
									<c:otherwise>
										<!-- Xử lý khi entity không tồn tại trong session -->
										<i class="fa-solid fa-user"></i>
										<h5>Tài khoản</h5>
									</c:otherwise>
								</c:choose>
							</div>
						</a>
						<c:if test="${sessionScope.user != null}">
							<a href="/user/logout">

								<div class="header__menu-item--user">
									<i class="fa-solid fa-user"></i>
									<h5>Log out</h5>
								</div>
							</a>
						</c:if>
					</div>
				</div>
				<div class="header__find-bar">
					<input type="text" class="find-bar" placeholder="Bạn muốn mua gì?" />
					<button>Tìm kiếm</button>
				</div>

				<div class="header__menu-item--bars" id="menu-btn">
					<i class="fa-solid fa-bars"></i>
				</div>
			</div>
			<!--  -->
		</div>
		<div class="content">
			<div class="signup">
				<div class="signup__main">
					<form action="" method="post">
						<div class="signup__main--content">
							<div class="content--header">
								<h1>THÔNG TIN TÀI KHOẢN
							</div>
							<div class="content--form">
								<div class="form__username">
									<label>Username</label> <input type="text"
										placeholder="your username" name="username"
										value="${user.username}" class="enter-name" />
								</div>
								<div class="form__c-pass">
									<label>password</label> <input type="password" name="password"
										value="${user.pass}" placeholder="enter your password" />
								</div>
								<div class="form__email">
									<label>Email</label> <input type="email" name="email"
										value="${user.email}" placeholder="enter your Email" />
								</div>
								<div class="form__fullname">
									<label>Fullname</label> <input type="text" name="fullname"
										value="${user.fullname}" placeholder="enter your Fullname" />
								</div>
								<div class="form__phone">
									<label>Phone</label> <input type="text" name="phone"
										value="${user.phone}" placeholder="enter your Phone Number" />
								</div>
								<button formaction="/user/info/update">Update</button>
							</div>
					</form>
				</div>
				<!-- <img src="<%=request.getContextPath()%>/img/bottom-img.png" alt="bottom-pic" class="bp" /> -->
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
					<li><a href="#">Copyright @1999-2020 CHUTICH.VN All rights
							Reserved.</a></li>
					<li><a href="#">Công Ty TNHH Chủ Tịch S.G (Nhà sách Chủ
							Tịch)</a></li>
					<li><a href="#">249 Đoàn Minh CHỦ TỊCH, F. Đoàn Minh Tuấn,
							Q.1, Tp. Hồ Chí Minh</a></li>
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
	<script src="<%=request.getContextPath()%>/js/script.js"></script>
	<script src="<%=request.getContextPath()%>/slick-slider/app.js"></script>
</body>
</html>

<script
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
