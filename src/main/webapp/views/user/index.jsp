<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:wght@100;300;400;500&family=Unbounded:wght@600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/2016f2764d.js"
	crossorigin="anonymous"></script>

<!-- LINK CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/index.css" />

<script
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
</head>
<body>
	<div class="container">
		<%@ include file="menu.jsp" %>
		 <div class="content">
			 <!-- <div class="content__slider-container">
				<div class="image-item">
					<div class="image">
						<img src="../img/book1.jpg" alt="book1" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book2.jpg" alt="book2" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book3.jpg" alt="book3" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book4.jpg" alt="book4" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book5.jpg" alt="book4" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book6.jpg" alt="book5" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book7.jpg" alt="book6" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book8.jpg" alt="book8" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book9.jpg" alt="book9" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book10.jpg" alt="book10" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book11.jpg" alt="book11" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book12.jpg" alt="book12" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book13.jpg" alt="book13" />
					</div>
				</div>
				<div class="image-item">
					<div class="image">
						<img src="../img/book14.jpg" alt="book14" />
					</div>
				</div>
			</div> -->
			<div class="content-banner">
				<img src="../img/banner1.jpg" alt="banner1" />
			</div>
			<div class="content__best-seller">
				<h4>
					<strong>Sách bán chạy</strong>
				</h4>
				<div class="best-seller__product">

					<c:forEach items="${books}" var="bo">
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
			</div> --%>
			<div class="content-banner">
				<img src="../img/banner2.jpg" alt="banner2" />
			</div>
			<div class="content__best-seller">
				<h4>
					<strong>Nổi bật</strong>
				</h4>
				<div class="best-seller__product">
					<div class="product-item">
						<div class="product">
							<a href="#" class="product-link"> <img
								src="../img/chotuixin1vedituoitho.jpg" alt="book-img"
								class="product-image" />
							</a> <span class="product-name"><a class="cart-button"
								href="../main/cart.html">Add to cart</a></span>
						</div>
					</div>
					<div class="product-item">
						<div class="product">
							<a href="#" class="product-link"> <img src="../img/book.png"
								alt="book-img" class="product-image" />
							</a> <span class="product-name"><a class="cart-button"
								href="../main/cart.html">Add to cart</a></span>
						</div>
					</div>
					<div class="product-item">
						<div class="product">
							<a href="#" class="product-link"> <img src="../img/anh7.jpg"
								alt="book-img" class="product-image" />
							</a> <span class="product-name"><a class="cart-button"
								href="../main/cart.html">Add to cart</a></span>
						</div>
					</div>
					<div class="product-item">
						<div class="product">
							<a href="#" class="product-link"> <img src="../img/anh13.jpg"
								alt="book-img" class="product-image" />
							</a> <span class="product-name"><a class="cart-button"
								href="../main/cart.html">Add to cart</a></span>
						</div>
					</div>
					<div class="product-item">
						<div class="product">
							<a href="#" class="product-link"> <img src="../img/anh14.jpg"
								alt="book-img" class="product-image" />
							</a> <span class="product-name"><a class="cart-button"
								href="../main/cart.html">Add to cart</a></span>
						</div>
					</div>
				</div>
			</div>
			<div class="content__about-us">
				<h1>ABOUT US</h1>
				<br />
				<p>Chào mừng đến với trang web sách của chúng tôi! Chúng tôi là
					một cộng đồng yêu sách, cam kết cung cấp cho bạn những trải nghiệm
					đọc sách tuyệt vời và đáng nhớ. Trang web sách của chúng tôi là một
					nơi tuyệt vời để khám phá và mua sắm các loại sách đa dạng. Chúng
					tôi cung cấp một bộ sưu tập phong phú của các thể loại sách, bao
					gồm tiểu thuyết, kinh doanh, khoa học, lịch sử, tự truyện và nhiều
					thể loại khác. Bất kể bạn đam mê thể loại nào, chúng tôi đều có
					những cuốn sách phù hợp với sở thích và nhu cầu của bạn. Chúng tôi
					cam kết cung cấp sách chất lượng cao từ các nhà xuất bản uy tín và
					tác giả hàng đầu. Đội ngũ chuyên gia của chúng tôi đã lựa chọn kỹ
					lưỡng các tác phẩm để đảm bảo rằng bạn nhận được những cuốn sách
					tốt nhất và đáng đọc. Trải nghiệm mua sắm trên trang web sách của
					chúng tôi rất dễ dàng và tiện lợi. Bạn có thể dễ dàng tìm kiếm, xem
					thông tin chi tiết và đặt hàng một cách nhanh chóng. Chúng tôi đảm
					bảo giao hàng nhanh chóng và an toàn, để bạn có thể sớm tận hưởng
					những cuốn sách mới. Ngoài ra, chúng tôi cũng cung cấp các đánh giá
					và nhận xét từ cộng đồng độc giả. Bạn có thể chia sẻ ý kiến của
					mình và đọc những đánh giá từ người đọc khác để có cái nhìn tổng
					quan về các cuốn sách. Hãy tham gia cùng chúng tôi trên trang web
					sách để khám phá vô số tác phẩm xuất sắc và thỏa sức đam mê đọc
					sách của bạn. Chúng tôi hy vọng trang web sách của chúng tôi sẽ trở
					thành điểm đến yêu sách hàng đầu của bạn!</p>
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
	<script src="../js/script.js"></script>
	<script src="../slick-slider/app.js"></script>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</html>