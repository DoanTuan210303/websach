package com.poly.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
@Data
@Entity
@Table(name = "book")
public class Book {
	@Id @NotBlank(message="Vui lÃ²ng nháº­p mÃ£ sÃ¡ch!")
	private String bookid;
	@NotBlank(message="Vui lÃ²ng nháº­p tÃªn sÃ¡ch!")
	private String title;
	private String describe;
//	@Min(0)
//	@NotNull(message="Vui lÃ²ng chá»n tÃ¡c giáº£!")
	@ManyToOne
	@JoinColumn(name = "authorid")
	private Author author;

//	@NotNull(message="Vui lÃ²ng nháº­p giÃ¡ bÃ¡n mong muá»‘n!")
	@ManyToOne
	@JoinColumn(name = "categoriesid")
	private Category categories;

	@Min(0)
	@NotNull(message="Vui lÃ²ng nháº­p giÃ¡ bÃ¡n mong muá»‘n!")
	private Float price;
	
	private String imagebook;
	private boolean ative = true;


}
