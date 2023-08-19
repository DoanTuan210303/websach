package com.poly.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.poly.model.Author;
import com.poly.model.Book;
import com.poly.model.Category;

public interface BookDAO extends JpaRepository<Book, String> {
	@Query(value = "SELECT TOP 5 b.bookid, b.title, b.describe, b.authorid, b.categoriesid, b.price, b.imagebook, b.ative "
	        + "FROM book b "
	        + "INNER JOIN ("
	        + "    SELECT bookid, SUM(quantity) AS totalQuantity "
	        + "    FROM items "
	        + "    GROUP BY bookid"
	        + ") i ON b.bookid = i.bookid "
	        + "WHERE b.ative = 1 " // Thêm điều kiện b.ative = true
	        + "ORDER BY i.totalQuantity DESC", nativeQuery = true)
	List<Book> selectTop5Books();

	@Query("SELECT b FROM Book b JOIN b.categories c WHERE c.namecategories = :categoryName")
	Page<Book> findByCategory(@Param("categoryName") String categoryName, Pageable pageable);

	@Query("SELECT b FROM Book b JOIN b.author a JOIN b.categories c WHERE b.id = :bookId")
	Book getBookById(@Param("bookId") String bookId);

	@Query("SELECT b FROM Book b WHERE b.categories.id = :categoryId")
	List<Book> findBooksByCategoryId(@Param("categoryId") String categoryId);

	@Query("SELECT b FROM Book b WHERE b.categories.id = :categoryId ORDER BY b.price DESC")
	List<Book> findTop5BooksByCategoryId(@Param("categoryId") String categoryId, Pageable pageable);

	@Query("SELECT b FROM Book b WHERE b.author.id = :authorId ORDER BY b.price DESC")
	List<Book> findTop5BooksByAuthorId(@Param("authorId") Integer authorId, Pageable pageable);

	@Query("SELECT b FROM Book b JOIN b.author a WHERE (LOWER(b.title) LIKE %:keyword% OR LOWER(a.fullname) LIKE %:keyword%) AND b.ative = 1")
	Page<Book> searchBooksByKeyword(@Param("keyword") String keyword, Pageable pageable);
	
	@Query("SELECT b FROM Book b WHERE b.ative = 1")
    Page<Book> findByActive(Pageable pageable);
	@Query("SELECT b FROM Book b WHERE b.ative = true")
	Page<Book> findAllActive(Pageable pageable);

}
