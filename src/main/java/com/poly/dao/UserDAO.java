package com.poly.dao;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.model.User;

public interface UserDAO extends JpaRepository<User, String> {
	User findByUsername(String username);

	User findByEmail(String email);
	@Query("SELECT u FROM User u WHERE u.ative = true")
	List<User> findAllActive(Sort sort);

}
