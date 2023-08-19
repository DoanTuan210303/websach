package com.poly.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
@Data
@Entity
@Table(name = "categories")
public class Category {
	@Id
	private String categoriesid;
	private String namecategories;
	private Boolean ative;
	
}
