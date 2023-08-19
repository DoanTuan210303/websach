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

</head>
<body>
	<c:forEach items="${cart.items}" var="item">
					<div class="content-cart__items">
					<div class="content-cart__item-image">
						<img src="<%=request.getContextPath()%>/img/${item.imagebook}" alt="book1" class="product-image" />
					</div>
					<div class="content-cart__item-info">
						<ul>
							<h1>Thông Tin Sản Phẩm</h1>
							<li>Tên Sách: ?</li>
							<li>Tác Giả: ?</li>
							<li>Số Lượng: ?</li>
							<li>Giá Sách: ?</li>
						</ul>
					</div>
				</div>
				</c:forEach>
</body>

</html>