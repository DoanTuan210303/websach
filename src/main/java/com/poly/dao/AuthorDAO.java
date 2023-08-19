package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.poly.model.Author;

public interface AuthorDAO extends JpaRepository<Author, Integer> {
	List<Author> findAllByAtiveTrue();
	
	@Query("SELECT au FROM Author au WHERE au.ative = true")
	List<Author> findAllActive();
	
	Author findByAuthorid(int authorid);

}
