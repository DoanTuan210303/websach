<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Landing page</title>
<link rel="stylesheet" href="lp.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200&family=Roboto&family=Unbounded:wght@600&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/2016f2764d.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="../css/lp.css" />
</head>
<body>
	<div class="signup">
		<div class="signup__main">
			<div class="signup__main--menu">
				<img src="../img/image.png" class="menu--img" />
				<ul class="menu--bar">
					<li>
						<button>
							<a href="/user/index">Home</a>
						</button>
					</li>
					<li>
						<button>
							<a href="/user/sign-in">Sign In</a>
						</button>
					</li>
					<li>
						<button style="background-color: #f5a623; border: none">
							<a href="./sign-up.html" style="color: white">Sign Up</a>
						</button>
					</li>
				</ul>
			</div>
			<div class="signup__main--content">
				<div class="content--header">
					<h1>
						TEACH <span>what you know,</span>
					</h1>
					<br />
					<h1>
						LEARN <span>what you don't.</span>
					</h1>
				</div>
				<form class="content--form" action="/register" method="post">
					<div class="form__username">
						<label>Username</label> <input name="username"
							placeholder="enter your username" />
					</div>
					<div class="form__c-pass">
						<label>password</label> <input type="password" name="password"
							placeholder="enter your password" />
					</div>
					<div class="form__password">
						<label>Comfirm</label> <input type="password" name="comfirm"
							placeholder="enter your password" />
					</div>
					<div class="form__email">
						<label>Email</label> <input type="email" name="email"
							placeholder="enter your Email" />
					</div>
					<div class="form__fullname">
						<label>Fullname</label> <input type="text" name="fullname"
							placeholder="enter your Fullname" />
					</div>
					<div class="form__phone">
						<label>Phone</label> <input type="text" name="phone"
							placeholder="enter your Phone Number" />
					</div>
					<div class="form__button-2">
						<button>
							<a>Sign Up</a>
						</button>
					</div>
				</form>
			</div>
			<!-- <img src="../img/bottom-img.png" alt="bottom-pic" class="bp" /> -->
		</div>
	</div>
</body>
</html>