package com.poly.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.CookieGenerator;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.poly.dao.BookDAO;
import com.poly.dao.CategoryDAO;
import com.poly.dao.ItemDAO;
import com.poly.dao.OrderDAO;
import com.poly.dao.UserCartDAO;
import com.poly.dao.UserDAO;
import com.poly.model.Book;
import com.poly.model.CartItem;
import com.poly.model.Item;
import com.poly.model.Order;
import com.poly.model.User;
import com.poly.model.UserCart;
import com.poly.service.BookService;
import com.poly.service.CartService;
import com.poly.service.CookieService;
import com.poly.service.EmailService;
import com.poly.service.ParamService;
import com.poly.service.SessionService;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Controller
public class HomeController {

	@Autowired
	CookieService cookieService;
	@Autowired
	ParamService paramService;
	@Autowired
	SessionService sessionService;
	@Autowired
	HttpServletRequest request;

	@Autowired
	BookDAO boDao;

	@Autowired
	CategoryDAO caDao;

	@Autowired
	UserDAO uDao;

	@Autowired
	OrderDAO orderDAO;

	@Autowired
	ItemDAO itemDao;

	@Autowired
	EmailService es;

	@Autowired
	private HttpSession session;
	
	@RequestMapping("/")
	public String index(Model model) {
		model.addAttribute("books", boDao.selectTop5Books());
		return "/user/index";
	}

//	GỌI TRANG INDEX
	@GetMapping("/user/index")
	public String GetIndex(Model model) {
		String username = (String) session.getAttribute("username");
		// Sử dụng username trong logic của trang home
		model.addAttribute("username", username);
		model.addAttribute("books", boDao.selectTop5Books());
		model.addAttribute("username", cookieService.getValue("username"));
		model.addAttribute("password", cookieService.getValue("password"));
		return "/user/index";
	}

//	GỌI TRANG TÀI KHOẢN
	@GetMapping("/user/sign-in")
	public String GetSignIn() {
		return "/user/sign-in";
	}

//	GỌI TRANG CHI TIẾT
	@GetMapping("/user/detail")
	public String GetDetail(Model model, Optional<Integer> p) {
		model.addAttribute("categoryItems", caDao.findAll());
		Pageable pageable = PageRequest.of(p.orElse(0), 10);
		Page<Book> books = boDao.findAllActive(pageable);
		model.addAttribute("page", books);
		return "/user/detail";
	}

//	GỌI TRANG CHI TIẾT SẢN PHẨM
	@GetMapping("/user/detail-item")
	public String GetDetailItem() {
		return "/user/detail-item";
	}

//	GỌI TRANG ĐĂNG KÍ
	@GetMapping("/user/sign-up")
	public String GetSignUp() {
		return "/user/sign-up";
	}

//	GỌI TRANG QUÊN MẬT KHẨU
	@GetMapping("/user/fogot-pass")
	public String GetFogotPass() {
		return "/user/fogot-pass";
	}

	// LOAD SÁCH THEO LOẠI
		@GetMapping("/books")
		public String getBooksByCategory(
				@RequestParam(value = "keyword" ,required = false) String keyword, Model model, Optional<Integer> p) {
//			model.addAttribute("books", boDao.findByCategory(categoryName));
//			model.addAttribute("categoryItems", caDao.findAll());
			
			Pageable pageable = PageRequest.of(p.orElse(0), 10);
//			Page<Book> books = boDao.findByCategory(categoryName, pageable);
			Page<Book> books;
			 if(keyword !=null){
				 books = boDao.searchBooksByKeyword(keyword, pageable);
			}else {
				books = boDao.findAll(pageable);
			}
			model.addAttribute("page", books);
			model.addAttribute("categoryItems", caDao.findAll());
			model.addAttribute("keyword", keyword);
			
			return "/user/detail"; // Trả về tên của trang JSP hiển thị danh sách sách
		}
		@GetMapping("/books1")
		public String getBooksByCategory1(@RequestParam(value = "categoryName", required = false) String categoryName,
				 Model model, Optional<Integer> p) {
//			model.addAttribute("books", boDao.findByCategory(categoryName));
//			model.addAttribute("categoryItems", caDao.findAll());
			
			Pageable pageable = PageRequest.of(p.orElse(0), 10);
//			Page<Book> books = boDao.findByCategory(categoryName, pageable);
			Page<Book> books;
			if (categoryName != null) {
				books = boDao.findByCategory(categoryName, pageable);
			} else {
				books = boDao.findAll(pageable);
			}
			model.addAttribute("page", books);
			model.addAttribute("categoryItems", caDao.findAll());

			return "/user/detail"; // Trả về tên của trang JSP hiển thị danh sách sách
		}	

	// ĐĂNG NHẬP
	@PostMapping("/login")
	public String login(@RequestParam("username") String username, @RequestParam("password") String password,
			Model model, HttpServletRequest request, HttpServletResponse response) {
		User user = uDao.findByUsername(username);
		boolean remember = paramService.getBoolean("remember", false);
		if (user != null && user.getPass().equals(password)) {
			// Xác thực thành công
			session.setAttribute("user", user);
			sessionService.set("username", username);
			if (remember) {
				cookieService.add("username", username, 1, response);
				cookieService.add("password", password, 1, response);
				model.addAttribute("username", username);
				model.addAttribute("password", password);
			} else {
				cookieService.remove("username", response);
				cookieService.remove("password", response);
			}
			session.removeAttribute("cartItems");
			session.removeAttribute("cartService");
			return "redirect:/user/index";
		} else {
			// Xác thực thất bại
			return "redirect:/user/sign-in";
		}
	}

	// ĐĂNG KÍ

	@GetMapping("/register")
	public String showRegistrationForm(Model model) {
		model.addAttribute("user", new User());
		return "/user/sign-up";
	}

	@PostMapping("/register")
	public String registerUser(@ModelAttribute("user") @Valid User user, BindingResult result,
			@RequestParam("email") String email, @RequestParam("fullname") String fullname,
			@RequestParam("username") String username, @RequestParam("phone") String phone,
			@RequestParam("password") String pass, Model model) {
		if (result.hasErrors()) {
			return "/user/sign-up";
		}

		// Kiểm tra xem người dùng đã tồn tại trong cơ sở dữ liệu hay chưa
		if (uDao.findByUsername(user.getUsername()) != null) {
			result.rejectValue("username", "error.username", "Username is already taken");
			return "/user/sign-up";
		}

		// Lưu thông tin email, fullname và phone vào thực thể User
		user.setEmail(email);
		user.setFullname(fullname);
		user.setPhone(phone);
		user.setPass(pass);
		user.setPosition(false);
		user.setAtive(true);
		session.setAttribute("username", username);
		// Lưu thông tin người dùng vào cơ sở dữ liệu
		uDao.save(user);
		return "redirect:/user/sign-in";
	}

	// TIÊM EMAIL
	@Autowired
	private EmailService emailService;

	@PostMapping("/forgot-password")
	public String processForgotPasswordForm(@RequestParam("email") String email) {
		String subject = "Forgot Password";
		Random random = new Random();
		int numbers = random.nextInt(90000) + 10000;
		List<User> us = uDao.findAll();
		for (User user : us) {
			if (user.getEmail().equals(email)) {
				es.sendEmail(email, subject, numbers);
				user.setPass(String.valueOf(numbers));
				uDao.save(user);
//					return "/user/index";
				session.setAttribute("user", user);
				sessionService.set("username", user);
				session.removeAttribute("cartItems");
				session.removeAttribute("cartService");
				return "/user/index";
			}
		}
//			es.sendEmail(email, subject, numbers);

		return "/user/fogot-pass";
	}

	// Các phương thức khác

	private String generateRandomPassword() {
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 5; i++) {
			int index = random.nextInt(characters.length());
			sb.append(characters.charAt(index));
		}
		return sb.toString();
	}

	// CHI TIẾT SẢN PHẨM
	@GetMapping("/book-details")
	public String getBookDetails(@RequestParam("id") String bookId, Model model) {
		Book book = boDao.getBookById(bookId);
		model.addAttribute("book", book);

		// Lấy danh sách các cuốn sách cùng thể loại
		Pageable pageable = PageRequest.of(0, 5);
		List<Book> relatedBooks = boDao.findTop5BooksByCategoryId(book.getCategories().getCategoriesid(), pageable);
		model.addAttribute("relatedBooks", relatedBooks);

		Pageable pageable2 = PageRequest.of(0, 5);
		List<Book> top5BooksByAuthor = boDao.findTop5BooksByAuthorId(book.getAuthor().getAuthorid(), pageable2);
		model.addAttribute("BookssameAuthor", top5BooksByAuthor);
		return "/user/detail-item";
	}

	// TÌM KIẾM
	@GetMapping("/search")
	public String searchBooks(@RequestParam("keyword") String keyword, Model model, Optional<Integer> p) {
		Pageable pageable = PageRequest.of(p.orElse(0), 10);
		Page<Book> books = boDao.searchBooksByKeyword(keyword, pageable);
		model.addAttribute("page", books);
		model.addAttribute("categoryItems", caDao.findAll());
		return "/user/detail";
	}

	// THÊM VÀO GIỎ HÀNG
	@Autowired
	private CartService cartService;

	@Autowired
	private UserCartDAO userCartDao;

	// THANH TOÁN
	// THANH TOÁN
	@GetMapping("/checkout")
	public String checkout(Model model, @RequestParam Map<String, String> requestParams) {
		// Lấy thông tin giỏ hàng từ session
		// Lấy thông tin giỏ hàng từ session
		CartService cartService = (CartService) session.getAttribute("cartService");
		List<CartItem> cartItems = cartService.getCartItems();

		// Lưu thông tin đơn hàng vào cơ sở dữ liệu (bảng "orders")
		Order order = new Order();
		order.setOrderdate(LocalDate.now());
		order.setPrice(cartService.calculateTotalPrice()); // Tính toán tổng giá trị đơn hàng
		String username = (String) session.getAttribute("username");
		order.setUsername(username); // Lấy thông tin tên người dùng đã đăng nhập
		double cartTotal = cartService.calculateTotalPrice();
		model.addAttribute("cartTotal", cartTotal);
		orderDAO.save(order); // Lưu đơn hàng vào cơ sở dữ liệu

		for (CartItem cartItem : cartItems) {
			Item item = new Item();
			item.setBook(cartItem.getBook());
			item.setQuantity(cartItem.getQuantity());
			item.setOrder(order);
			itemDao.save(item);
		}
		// Xóa thông tin giỏ hàng sau khi đã thanh toán
		cartService.clearCart();

		// Chuyển hướng người dùng đến trang thanh toán hoặc trang xác nhận đơn hàng
		return "redirect:/user/cart"; // Thay đổi thành URL của trang thanh toán hoặc trang xác nhận đơn hàng
	}

	// ...
	@GetMapping("/add-to-cart")
	public String addToCart(@RequestParam("bookId") String bookId, Model model,
			@RequestParam("quantity") Integer quantity) {
		if (session.getAttribute("user") == null) {
			return "user/sign-in";
		} else {
			// Add the book to the cart using the CartService
			Book book = boDao.getBookById(bookId);

			CartItem cartItem = new CartItem();
			cartItem.setBook(book);
			cartItem.setQuantity(quantity);

			cartService.addToCart(cartItem);

			// Lưu đối tượng cartService vào session
			session.setAttribute("cartService", cartService);
			// Lấy danh sách sách trong giỏ hàng từ CartService
			List<CartItem> cartItems = cartService.getCartItems();

			// Lưu danh sách sách vào session
			session.setAttribute("cartItems", cartItems);
			return "redirect:/user/cart";
		}
	}

	@GetMapping("/user/cart")
	public String GetCart(Model model) {
		List<CartItem> listCart = cartService.getCartItems();
		// Redirect the user to the cart page
		double cartTotal = cartService.calculateTotalPrice();
		model.addAttribute("cartTotal", cartTotal);
		model.addAttribute("cartItems", listCart);
		return "/user/cart";
	}

	@GetMapping("/cart/update")
	public String updatePrice(@RequestParam("id") String id, @RequestParam("quantity") int quantity, Model model) {
		// Lấy thông tin giỏ hàng từ session
		CartService cartService = (CartService) session.getAttribute("cartService");
		List<CartItem> cartItems = cartService.getCartItems();

		// Cập nhật giá sách trong giỏ hàng
		for (CartItem cartItem : cartItems) {
			if (cartItem.getBook().getBookid().equals(id)) {
				float newPrice = cartItem.getBook().getPrice() * quantity;
				cartItem.getBook().setPrice(newPrice);
				cartItem.setQuantity(quantity);
				break; // Tìm thấy sách cần cập nhật, thoát khỏi vòng lặp
			}
		}
		session.setAttribute("cartService", cartService);
		// Tính lại tổng giá trị đơn hàng
		double cartTotal = cartService.calculateTotalPrice();
		model.addAttribute("cartTotal", cartTotal);
		return "redirect:/user/cart";
	}

	@RequestMapping("/user/logout")
	public String logout(HttpSession session, Model model) {
		// Xóa entity khỏi session
		model.addAttribute("books", boDao.selectTop5Books());
		session.removeAttribute("user");
		return "user/index";
	}

	@RequestMapping("/user/info")
	public String infouser(HttpSession session, Model model) {
		User entity = (User) session.getAttribute("user");
		model.addAttribute("user", entity);
		return "user/user-info";
	}

	@RequestMapping("/user/info/update")
	public String infrouserSave(HttpSession session, Model model, @RequestParam("username") String username,
			@RequestParam("password") String password, @RequestParam("email") String email,
			@RequestParam("fullname") String fullname, @RequestParam("phone") String phone) {
		User entity = uDao.findById(username).get();
		entity.setPass(password);
		entity.setEmail(email);
		entity.setFullname(fullname);
		entity.setPhone(phone);
		uDao.save(entity);
		model.addAttribute("user", entity);
		System.out.print(username);
		return "user/user-info";
	}

	public boolean check(HttpServletRequest rq, HttpSession session) {
		session = rq.getSession(false);
		if (session != null && !session.isNew()) {
			return true;
		} else {
			return false;
		}
	}
}
