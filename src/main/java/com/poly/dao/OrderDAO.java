package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.poly.model.Order;
import com.poly.model.User;

public interface OrderDAO extends JpaRepository<Order, Integer> {
	Order findByUsername(String username);
}
