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
<title>Giỏ Hàng</title>
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
		<div class="content content-2">
			<div class="content-cart">
				<div class="content-header">
					<h1>
						<strong>GIỎ HÀNG</strong>
					</h1>
				</div>

				<c:forEach items="${cartItems}" var="cartItem" varStatus="status">
					<div class="content-cart__items">
						<div class="content-cart__item-image">
							<img src="../sach/${cartItem.book.imagebook}" alt="book1"
								class="product-image" />
						</div>
						<div class="content-cart__item-info">
							<ul>
								<h1>Thông Tin Sản Phẩm</h1>
								<li>Tên Sách: ${cartItem.book.title }</li>
								<li>Tác Giả: ${cartItem.author.fullname }</li>
								<li class="quantity">Số Lượng: <input type="number"
									id="${cartItem.book.bookid }input" name="quantity" min="1"
									value="${cartItem.quantity}"
									onblur="updateQty('${cartItem.book.bookid}')">
								</li>
								<li>Giá Sách: <span class="price">${cartItem.book.price}</span></li>

							</ul>
						</div>
					</div>
				</c:forEach>

			</div>
			<div class="content-pay">
				<div class="content-pay__method">
					<h6 class="pay-header">Phương Thức Thanh Toán</h6>
					<div class="content-pay__method-item">
						<input type="radio" id="payment-method-1" name="payment-method"
							value="method-1" /> <label for="payment-method-1"><i
							class="fa-brands fa-cc-visa fa-bounce"></i></label>
					</div>
					<div class="content-pay__method-item">
						<input type="radio" id="payment-method-2" name="payment-method"
							value="method-2" /> <label for="payment-method-2"><i
							class="fa-brands fa-google-pay fa-bounce"></i></label>
					</div>
					<div class="content-pay__method-item">
						<input type="radio" id="payment-method-3" name="payment-method"
							value="method-3" /> <label for="payment-method-3"><i
							class="fa-brands fa-cc-mastercard fa-bounce"></i></label>
					</div>
					<div class="content-pay__method-item">
						<input type="radio" id="payment-cash" name="payment-method"
							value="cash" /> <label for="payment-cash"><p>Thanh
								toán trực tiếp</p></label>
					</div>
				</div>
				<div class="content-pay__info">
					<h6 class="pay-header">Thông Tin Đơn Hàng</h6>
					<div class="content-pay__info-total">Tổng sản phẩm:
						${cartItems.size()}</div>
					<div class="content-pay__info-ship">Phí vận chuyển: Miễn Phí</div>
					<div class="content-pay__info-phone">
						<input type="text" name="address" placeholder="Số Điện Thoại" />
					</div>
					<div class="content-pay__info-address">
						<input type="text" name="address" placeholder="Địa chỉ" />
					</div>
					<hr />
					<div class="content-pay__info-payments">Tổng tiền: <span class="totalPrice">${cartTotal }</span> </div>
					<div class="content-pay__info-button">
						<a href="/checkout">Thanh Toán</a>
					</div>
				</div>
			</div>
		</div>
		<footer>
			<div class="footer-container" style="margin-top: 0">
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	
	<script type="text/javascript">
		function updateQty(id) {
			location.href = "/cart/update?id=" + id + "&quantity="
					+ document.getElementById(id + "input").value;
		}
	</script>
	
	
</html>