package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.model.Category;

public interface CategoryDAO extends JpaRepository<Category, String> {
	List<Category> findAllByAtiveTrue();
	
	@Query("SELECT c FROM Category c WHERE c.ative = true")
	List<Category> findAllActive();

}
