package com.poly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.reflect.CatchClauseSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.poly.dao.AuthorDAO;
import com.poly.dao.BookDAO;
import com.poly.dao.CategoryDAO;
import com.poly.dao.ReportRepository;
import com.poly.dao.UserDAO;
import com.poly.model.Author;
import com.poly.model.Book;
import com.poly.model.Category;
import com.poly.model.Report;
import com.poly.model.User;
import com.poly.service.ImageService;
import com.poly.service.ParamService;
import com.poly.service.SessionService;

@Controller
public class AdminController {

	@Autowired
	UserDAO dao;
	@Autowired
	ReportRepository daoReport;
	@Autowired
	CategoryDAO categoryDAO;
	@Autowired
	AuthorDAO authorDAO;
	@Autowired
	SessionService sessionService;
	@Autowired
	BookDAO bookDao;
	@Autowired
	UserDAO uDao;
	@Autowired
	ParamService paramService;
	@Autowired
	ServletContext app;
	String img;
	public boolean check(HttpServletRequest rq, HttpSession session) {
		session = rq.getSession(false);
		User us  = uDao.findByUsername(sessionService.get("username"));
		if (session!=null && !session.isNew() && us.getPosition()== Boolean.TRUE) {
			return true;
		} else {
			return false;
		}
	}
//	
	@GetMapping("/admin")
	public String index(HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field,HttpServletRequest rq) {
		if (check(rq, session)) {
			double tong = 0;
			List<Report> books = daoReport.findBookInfo();
			model.addAttribute("books1", books);
			for (Report report1 : books) {
				tong += report1.getTong();
			}
			model.addAttribute("tong", tong);
			List<Category> list = categoryDAO.findAll();
			model.addAttribute("loai", list);
			double tong1 = 0;
			List<Report> books1 = daoReport.findBookInfo();
			model.addAttribute("books2", books1);
			for (Report report1 : books1) {
				tong1 += report1.getTong();
			}
			model.addAttribute("tong1", tong1);
			String kword = kw.orElse(sessionService.get("key") == null ? "" : sessionService.get("key"));
			sessionService.set("key", kword);

			// Quáº£n lÃ½ sÃ¡ch
			Book bookQly = new Book();
			model.addAttribute("bookQly", bookQly);

			// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
			Pageable pageable = PageRequest.of(p.orElse(0), 5);
			model.addAttribute("books", bookDao.searchBooksByKeyword(kword, pageable));

			// Sáº¯p xáº¿p thÃ´ng tin ngÆ°á»i dÃ¹ng
			Sort sort = Sort.by(Direction.ASC, field.orElse("username"));

			// ThÃ´ng tin ngÆ°á»i dÃ¹ng
			List<User> listUser = uDao.findAllActive(sort);
			model.addAttribute("listUser", listUser);

			call(session, model, p, kw, field);
			return "admin/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@PostMapping("/admin/update")
	public String admin(HttpSession session, Model model, @RequestParam("username") String username,
			@RequestParam("fullname") String fulname, @RequestParam("email") String email,
			@RequestParam("phone") String phone,HttpServletRequest rq) {
		User entity = dao.findById(username).get();
		entity.setFullname(fulname);
		entity.setEmail(email);
		entity.setPhone(phone);
		dao.save(entity);
		session.setAttribute("user", entity);
		User entity1 = (User) session.getAttribute("user");
		model.addAttribute("user", entity1);
		model.addAttribute("item", new Category());
		return "redirect:/admin";
	}

	@RequestMapping("/book-info1")
	public String postBookInfo1(HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field, @RequestParam("maloai") String ma,HttpServletRequest rq) {
		double tong = 0;
		List<Report> books = daoReport.findBook(ma);
		model.addAttribute("books1", books);
		for (Report report1 : books) {
			tong += report1.getTong();
		}
		model.addAttribute("tong", tong);
		List<Category> list = categoryDAO.findAll();
		model.addAttribute("loai", list);
		double tong1 = 0;
		List<Report> books1 = daoReport.findBookInfo();
		model.addAttribute("books2", books1);
		for (Report report1 : books1) {
			tong1 += report1.getTong();
		}
		model.addAttribute("tong1", tong1);
		model.addAttribute("item", new Category());
		call(session, model, p, kw, field);
		return "admin/admin";
	}

	@RequestMapping("/book-info2")
	public String getBookInfo2(HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field, @RequestParam("a") String ngay1,
			@RequestParam("b") String ngay2,HttpServletRequest rq) {
//	        List<Report> books = dao.findBookfordate("2020-10-09", "2020-11-11");
		if (check(rq, session)) {
			double tong = 0;
			LocalDate date1 = LocalDate.parse(ngay1);
			LocalDate date2 = LocalDate.parse(ngay2);
			if (date1.isBefore(date2)) {
				List<Report> books = daoReport.findBookfordate(ngay1, ngay2);
				model.addAttribute("books2", books);
				for (Report report1 : books) {
					tong += report1.getTong();
				}
				model.addAttribute("tong1", tong);
				System.out.print(ngay1);

				double tong1 = 0;
				List<Report> books1 = daoReport.findBookInfo();
				model.addAttribute("books1", books1);
				for (Report report1 : books) {
					tong += report1.getTong();
				}
				model.addAttribute("tong", tong1);
				List<Category> list = categoryDAO.findAll();
				model.addAttribute("loai", list);
				model.addAttribute("item", new Category());
				call(session, model, p, kw, field);
				return "admin/admin";
			} else {
				List<Report> books = daoReport.findBookInfo();
				model.addAttribute("books2", books);
				for (Report report1 : books) {
					tong += report1.getTong();
				}
				model.addAttribute("tong1", tong);

				double tong1 = 0;
				List<Report> books1 = daoReport.findBookInfo();
				model.addAttribute("books1", books1);
				for (Report report1 : books1) {
					tong += report1.getTong();
				}
				model.addAttribute("tong", tong1);
				List<Category> list = categoryDAO.findAll();
				model.addAttribute("loai", list);
				model.addAttribute("item", new Category());
				call(session, model, p, kw, field);
				return "admin/admin";
			}
		} else {
			return "user/sign-in";
		}
		
	}

//	
	public void call(HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field) {
		model.addAttribute("item", new Category());
		model.addAttribute("category", categoryDAO.findAllByAtiveTrue());
		model.addAttribute("author", new Author());
		model.addAttribute("authorList", authorDAO.findAllByAtiveTrue());
		User entity = (User) session.getAttribute("user");
		model.addAttribute("user", entity);
		String kword = kw.orElse(sessionService.get("key") == null ? "" : sessionService.get("key"));
		sessionService.set("key", kword);

		// Quáº£n lÃ½ sÃ¡ch
		Book bookQly = new Book();
		model.addAttribute("bookQly", bookQly);

		// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
		Pageable pageable = PageRequest.of(p.orElse(0), 5);
		model.addAttribute("books", bookDao.searchBooksByKeyword(kword, pageable));

		// Sáº¯p xáº¿p thÃ´ng tin ngÆ°á»i dÃ¹ng
		Sort sort = Sort.by(Direction.ASC, field.orElse("username"));

		// ThÃ´ng tin ngÆ°á»i dÃ¹ng
		List<User> listUser = uDao.findAllActive(sort);
		model.addAttribute("listUser", listUser);
	}

	@RequestMapping("/admin/add")
	public String addCategory(HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field, HttpServletRequest request,
			@ModelAttribute("item") Category category) {
		if (check(request, session)) {
			category.setCategoriesid(request.getParameter("categoryId"));
			category.setNamecategories(request.getParameter("name"));
			call(session, model, p, kw, field);
			category.setAtive(true);
			categoryDAO.save(category);
			return "admin/admin";
		}else {
			return "use/sign-in";
		}
		
	}

	@RequestMapping("/admin/edit")
	public String editCategory(HttpServletRequest request, @RequestParam("id") String Id, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field) {
		if (check(request, session)) {
			Category cate = categoryDAO.findById(Id).get();
			model.addAttribute("item", cate);
			call(session, model, p, kw, field);
			return "admin/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/admin/update")
	public String updateCategory(HttpServletRequest request,@ModelAttribute("item") Category category, Model model) {
		if (check(request, null)) {
			category.setAtive(true);
			categoryDAO.save(category);
			model.addAttribute("category", categoryDAO.findAllByAtiveTrue());
			model.addAttribute("authorList", authorDAO.findAllByAtiveTrue());
			return "admin/adminn";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/admin/delete")
	public String deleteCategory(HttpServletRequest request, @ModelAttribute("item") Category category, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field) {
		if (check(request, session)) {
			category.setAtive(false);
			call(session, model, p, kw, field);
			categoryDAO.save(category);
			return "admin/admin";	
		}else {
			return "user/sign-in";
		}
		
	}

	@PostMapping("/admin/addAuthor")
	public String addCategory(HttpServletRequest request, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field, @ModelAttribute("item") Author author) {
		if (check(request, session)) {
			int count = authorDAO.findAll().size();
			author.setAuthorid(count + 1);
			author.setFullname(request.getParameter("AuthorName"));
			author.setStory(request.getParameter("AuthorStory"));
			author.setAtive(true);
			authorDAO.save(author);
			call(session, model, p, kw, field);
			return "admin/admin";
		} else {
			return "user/sign-in";
		}
		
	}

//	@RequestMapping("/admin/editAuthor")
//	public String editAuthor(HttpServletRequest request,@PathVariable("id") int id, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
//			@RequestParam("field") Optional<String> field) {
//		if (check(request, session)) {
//			model.addAttribute("item", new Category());
//			Author author = authorDAO.findById(id).get();
//			model.addAttribute("author", author);
//			model.addAttribute("authorList", authorDAO.findAll());
//			call(session, model, p, kw, field);
//
//			return "admin/admin";	
//		}else {
//			return "user/sign-in";
//		}
//		
//	}
	@RequestMapping("/admin/editAuthor")
	public String editAuthor(HttpServletRequest request,@RequestParam("id") int id, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field) {
		if (check(request, session)) {
			call(session, model, p, kw, field);
			model.addAttribute("item", new Category());
			Author author = authorDAO.findByAuthorid(id);
			model.addAttribute("author", author);
			model.addAttribute("authorList", authorDAO.findAll());
			

			return "admin/admin";	
		}else {
			return "user/sign-in";
		}
		
	} 
	@RequestMapping("/admin/updateAuthor")
	public String updateAuthor(HttpServletRequest request, @RequestParam("authorId") int id,
			@RequestParam("fullName") String name, @RequestParam("story") String story, HttpSession session, Model model, Optional<Integer> p, @RequestParam("key") Optional<String> kw,
			@RequestParam("field") Optional<String> field) {
		if (check(request, session)) {
			Author author = authorDAO.findById(id).get();
			author.setFullname(name);
			author.setStory(story);
			authorDAO.save(author);
			model.addAttribute("item", new Category());
			call(session, model, p, kw, field);
			return "admin/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/qly-books-action/edit")
	public String actionformEdit(HttpServletRequest request,HttpSession session, Model model, @RequestParam("id") String id, Optional<Integer> p) {
		// TÃ¬m sÃ¡ch vÃ  Ä‘áº©y lÃªn form
		if (check(request, session)) {
			Book bookQly = bookDao.findById(id).get();
			model.addAttribute("bookQly", bookQly);
			img = bookQly.getImagebook();
			// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
			sessionService.set("key", "");
			Pageable pageable = PageRequest.of(p.orElse(0), 5);
			model.addAttribute("books", bookDao.findAllActive(pageable));

			return "redirect:/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/qly-books-action/Them")
	public String actionformThem(HttpServletRequest request,Model model, Optional<Integer> p, @Validated @ModelAttribute("bookQly") Book bookQly,
			BindingResult result, @RequestParam("book-image") MultipartFile file) throws IOException {
		if (check(request, null)) {
			// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
			sessionService.set("key", "");
			Pageable pageable = PageRequest.of(p.orElse(0), 5);
			model.addAttribute("books", bookDao.findAllActive(pageable));
			if (result.hasErrors()) {
				return "/admin/admin";
			} else {
				if (!file.isEmpty()) {
					String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());

					// Đường dẫn đến thư mục img trong thư mục static
					String destinationPath = "src\\main\\webapp/img/";

					// Tạo đối tượng File đại diện cho thư mục đích
					File destinationFolder = new File(destinationPath);

					// Tạo đường dẫn đến file đích
					Path destinationFilePath = Paths.get(destinationFolder.getAbsolutePath(), originalFilename);

					// Lưu file hình vào thư mục đích
					file.transferTo(destinationFilePath.toFile());
					bookQly.setImagebook(file.getOriginalFilename());
//					//LÆ°u sÃ¡ch
					bookDao.save(bookQly);
				}
			}
			return "redirect:/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/qly-books-action/Sua")
	public String actionformSua(HttpServletRequest request,Model model, Optional<Integer> p, @Validated @ModelAttribute("bookQly") Book bookQly,
			BindingResult result, @RequestParam("book-image") MultipartFile file) throws IOException {
		if (check(request, null)) {
			// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
			sessionService.set("key", "");
			Pageable pageable = PageRequest.of(p.orElse(0), 5);
			model.addAttribute("books", bookDao.findAllActive(pageable));
			if (result.hasErrors()) {
				return "/admin/admin";
			} else {
				if (!file.isEmpty()) {
					String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());

					// Đường dẫn đến thư mục img trong thư mục static
					String destinationPath = "src\\main\\webapp/img/";

					// Tạo đối tượng File đại diện cho thư mục đích
					File destinationFolder = new File(destinationPath);

					// Tạo đường dẫn đến file đích
					Path destinationFilePath = Paths.get(destinationFolder.getAbsolutePath(), originalFilename);

					// Lưu file hình vào thư mục đích
					file.transferTo(destinationFilePath.toFile());
					bookQly.setImagebook(file.getOriginalFilename());
//						//LÆ°u sÃ¡ch
					bookDao.save(bookQly);

				} else {
					if (file.getOriginalFilename().isEmpty()) {
						bookQly.setImagebook(img);
						bookDao.save(bookQly);
					} else {
						bookQly.setImagebook(file.getOriginalFilename());
//						//LÆ°u sÃ¡ch
						bookDao.save(bookQly);
					}
				}

			}
			return "redirect:/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/qly-books-action/Xoa")
	public String actionformXoa(HttpServletRequest request,Model model, Optional<Integer> p, Book bookQly) {
		if (check(request, null)) {
			// Set Active vá» false Ä‘á»ƒ áº©n sÃ¡ch
			bookQly.setAtive(false);
			// LÆ°u sÃ¡ch
			bookDao.save(bookQly);

			// PhÃ¢n trang, hiá»ƒn thá»‹ quáº£n lÃ½ sÃ¡ch
			sessionService.set("key", "");
			Pageable pageable = PageRequest.of(p.orElse(0), 5);
			model.addAttribute("books", bookDao.findAllActive(pageable));
			return "redirect:/admin";
		} else {
			return "user/sign-in";
		}
		
	}

	@RequestMapping("/Qly-user-action/remove")
	public String actionformUserXoa(HttpServletRequest request,Model model, @RequestParam("username") String username,
			@RequestParam("field") Optional<String> field) {
		if (check(request, null)) {
			// TÃ¬m user muá»‘n xoÃ¡
			User user = uDao.findById(username).get();
			// Set Active false áº©n user
			user.setAtive(false);
			// LÆ°u
			uDao.save(user);

			// Sáº¯p xáº¿p thÃ´ng tin ngÆ°á»i dÃ¹ng
			Sort sort = Sort.by(Direction.ASC, field.orElse("username"));
			// Load láº¡i dá»¯ liá»‡u
			List<User> listUser = uDao.findAllActive(sort);
			model.addAttribute("listUser", listUser);

			return "redirect:/admin/admin";
		} else {
			return "user/sign-in";
		}
		
	}

//Há»— trá»£ form Quáº£n lÃ½ sÃ¡ch
	@ModelAttribute("author1")
	public List<Author> getAuthor() {
		List<Author> list = authorDAO.findAllActive();
		return list;
	}

	@ModelAttribute("listCategory")
	public List<Category> getCategory() {
		List<Category> list = categoryDAO.findAllActive();
		return list;
	}

}
