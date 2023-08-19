package com.poly.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.poly.dao.BookDAO;
import com.poly.model.Book;

@Service
public class BookService {
	private BookDAO boDao;

	public Book getBookById(String id) {
		// Sử dụng productRepository để lấy thông tin sản phẩm từ cơ sở dữ liệu
		Optional<Book> optionalBook = boDao.findById(id);
		return optionalBook.orElse(null);
	}
}
