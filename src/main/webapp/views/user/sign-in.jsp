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
						<button style="background-color: #f5a623; border: none">
							<a href="/user/sign-in" style="color: white">Sign In</a>
						</button>
					</li>
					<li>
						<button>
							<a href="/user/sign-up">Sign Up</a>
						</button>
					</li>
				</ul>
			</div>
			<div class="signup__main--content" action="/user/login" method="post">
				<div class="content--header">
					<h1>
						TEACH <span>what you know,</span>
					</h1>
					<br />
					<h1>
						LEARN <span>what you don't.</span>
					</h1>
				</div>
				<form class="content--form" action="/login" method="post">
					<div class="form__email">
						<label>Username</label> <input type="text" value="${username }" name="username"
							placeholder="enter your username" />
					</div>
					<div class="form__password">
						<label>password</label> <input type="password" value="${password }" name="password"
							placeholder="enter your password" />
					</div>
					<div class="form__check">
						<input type="checkbox" id="radio-pass" name="remember" value="${remember }"/> <label>Remember
							password?</label>
					</div>
					<div class="form__button">
						<button>
							<a href="/user/fogot-pass">Forgot pass</a>
						</button>
						<button type="submit">
							<a>Login</a>
						</button>
					</div>
				</form>
			</div>
			<img src="../img/bottom-img.png" alt="bottom-pic" class="bp" />
		</div>
	</div>
</body>
</html>