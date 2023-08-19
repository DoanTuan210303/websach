package com.poly.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Report {
    @Id
    private String imagebook;
    @Column(name="title")
    private String title;
    @Column(name="fullname")
    private String fullname;
    @Column(name="quantity")
    private int quantity;
    @Column(name="price")
    private float price;
    @Column(name="tong")
    private double tong;
}