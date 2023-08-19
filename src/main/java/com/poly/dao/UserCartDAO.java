package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.model.Book;
import com.poly.model.Order;
import com.poly.model.User;
import com.poly.model.UserCart;

public interface UserCartDAO extends JpaRepository<UserCart, Integer> {
	List<UserCart> findByUser(User user);
	
	 UserCart findByUserAndBook(User user, Book book);
}
