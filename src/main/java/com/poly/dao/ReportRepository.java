package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;

import com.poly.model.Report;


public interface ReportRepository extends JpaRepository<Report, String> {
	@Query(value = "SELECT b.imagebook, b.title, a.fullname, SUM(i.quantity) AS quantity, b.price, (SUM(i.quantity) * b.price) AS tong "
			+ "FROM Book b " + "JOIN Author a ON b.authorId = a.authorId " + "JOIN Items i ON b.bookId = i.bookId "
			+ "GROUP BY b.imagebook, b.title, a.fullname, b.price", nativeQuery = true)
	List<Report> findBookInfo();
	@Query(value = "SELECT book.imagebook, book.title, author.fullname, SUM(items.quantity) AS 'quantity', book.price, (SUM(items.quantity) * book.price) AS 'tong' "
			+ "FROM book "
			+ "JOIN author ON book.authorid = author.authorid "
			+ "JOIN items ON book.bookid = items.bookid "
			+ "JOIN categories ON book.categoriesid = categories.categoriesid "
			+ "WHERE categories.categoriesid LIKE ?1 "
			+ "GROUP BY book.imagebook, book.title, author.fullname, book.price;",nativeQuery = true)
	List<Report> findBook(String key);
	@Query(value = "SELECT book.imagebook, book.title, author.fullname, SUM(items.quantity) AS quantity, book.price, (SUM(items.quantity) * book.price) AS tong "
			+ "FROM book "
			+ "JOIN author ON book.authorid = author.authorid "
			+ "JOIN items ON book.bookid = items.bookid "
			+ "JOIN orders ON items.ordersid = orders.ordersid "
			+ "WHERE orders.orderdate >= ?1 AND orders.orderdate <= ?2 "
			+ "GROUP BY book.imagebook, book.title, author.fullname, book.price;" , nativeQuery = true)
	List<Report> findBookfordate(String date1, String date2);
}
