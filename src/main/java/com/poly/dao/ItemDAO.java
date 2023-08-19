package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.poly.model.Item;

public interface ItemDAO extends JpaRepository<Item, Integer> {

}
