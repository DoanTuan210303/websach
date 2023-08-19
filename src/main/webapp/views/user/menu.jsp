<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header">
	<c:choose>
		<c:when
			test="${sessionScope.user != null && sessionScope.user.position==true}">
			<a href="/admin"> <img class="header__logo"
				src="../img/logo2.png" alt="logo_web" />
			</a>
		</c:when>
		<c:otherwise>
			<a href="#"> <img class="header__logo" src="../img/logo2.png"
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
				</a> 

						<c:choose>
							<c:when
								test="${sessionScope.user != null && sessionScope.user.position==false}">
								<a href="/user/info">
									<div class="header__menu-item--user">
										<i class="fa-solid fa-user"></i>
										<h5>${sessionScope.user.username}</h5>
									</div>
								</a>
							</c:when>
							<c:when test="${sessionScope.user != null}">
								<!-- Xử lý khi entity tồn tại trong session -->
								<a href="./user-info.html">
									<div class="header__menu-item--user">
										<i class="fa-solid fa-user"></i>
										<h5>${sessionScope.user.username}</h5>
									</div>
								</a>
							</c:when>
							<c:otherwise>
							<a href="/user/sign-in">
							<div class="header__menu-item--user">
								<!-- Xử lý khi entity không tồn tại trong session -->
								<i class="fa-solid fa-user"></i>
								<h5>Tài khoản</h5>
								</div>
								</a>
							</c:otherwise>
						</c:choose>
					
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
		<form class="header__find-bar" action="/search" method="get">
			<input type="text" class="find-bar" placeholder="Bạn muốn mua gì?"
				name="keyword" />
			<button>Tìm kiếm</button>
		</form>
		<div class="header__menu-item--bars" id="menu-btn">
			<i class="fa-solid fa-bars"></i>
		</div>
	</div>
	<!--  -->
</div>