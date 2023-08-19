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
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/index.css" />
<!-- . -->
<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
</head>
<body>
	<div class="container">
		<%@ include file="menu.jsp" %>
		<div class="content__detail-item">
			<div class="content__detail-item-info">
				<img src="../sach/${book.imagebook }" alt="book-img"
					class="detail-img" />
				<div class="content-detail__info">
					<h1>${book.title }</h1>
					<h4>Tác Giả: ${book.author.fullname}</h4>
					<h4>Loại sách: ${book.categories.namecategories }</h4>
					<div class="content-detail__infor-reviews">
						<h4>Đánh giá:</h4>
						<i class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i>
						<i class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i>
						<i class="fa-regular fa-star"></i>
					</div>
					<hr />
					<h3 class="price">${book.price }</h3>
					<hr />
					<div class="content-detail__info-add">
						<div class="info-add__info">
							<h3>Phí vận chuyển</h3>
							<p>Miễn phí vận chuyển</p>
						</div>
						<div class="info-add__info-2">
							<p>
								<i class="fa-sharp fa-solid fa-shield"></i>Sản phẩm chính hãng.
							</p>
							<p>
								<i class="fa-sharp fa-solid fa-shield"></i>Cảm kết hoàn tiền
								100% nếu phát hiện sách giả.
							</p>
							<p>
								<i class="fa-sharp fa-solid fa-shield"></i>Cam kết 1 đổi 1 khi
								phát hiện sản phẩm bị hỏng hóc
							</p>
						</div>
						<div class="info-add__button">
				
								<a href="/add-to-cart?bookId=${book.bookid}&quantity=1" class="add-to-cart">Add to cart by quantity</a>	
						</div>

					</div>
				</div>
			</div>
			<div class="content-detail__desc">
				<h1>Mô tả sản phẩm</h1>
				<p>${book.describe }</p>
			</div>
		</div>
		<div class="content__best-seller">
			<h4>
				<strong>Cùng tác giả</strong>
			</h4>
			<div class="best-seller__product">
				<c:forEach var="bo" items="${BookssameAuthor}">
					<div class="product-item">
						<div class="product">
							<a href="/book-details?id=${bo.bookid}" class="product-link">
								<img src="../sach/${bo.imagebook }" alt="book1"
								class="product-image" /> <span class="product-name">${bo.title }</span>
							</a>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>
		<div class="content__best-seller">
			<h4>
				<strong>Cùng thể loại</strong>
			</h4>



			<div class="best-seller__product">
				<c:forEach var="bo" items="${relatedBooks}">
					<div class="product-item">
						<div class="product">
							<a href="/book-details?id=${bo.bookid}" class="product-link">
								<img src="../sach/${bo.imagebook }" alt="book1"
								class="product-image" /> <span class="product-name">${bo.title }</span>
							</a>
						</div>
					</div>
				</c:forEach>
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
<script>
	var priceElement = document.querySelector(".price");
	var price = priceElement.innerHTML;
	var formattedPrice = parseFloat(price).toLocaleString("en-US", {
		minimumFractionDigits : 0,
		maximumFractionDigits : 0,
	});
	priceElement.innerHTML = formattedPrice + " Đ";
</script>
</html>