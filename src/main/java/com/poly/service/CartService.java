package com.poly.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.poly.model.Book;
import com.poly.model.CartItem;
import com.poly.model.User;

@Service
public class CartService {
	private List<CartItem> cartItems = new ArrayList<>();

	public void addToCart(CartItem cartItem) {
		// Kiểm tra xem cuốn sách đã có trong giỏ hàng chưa
		boolean bookExists = false;
		for (CartItem item : cartItems) {
			if (item.getBook().getBookid().equals(cartItem.getBook().getBookid())) {
				// Sách đã có trong giỏ hàng, cập nhật số lượng
				item.setQuantity(item.getQuantity() + cartItem.getQuantity());
				bookExists = true;
				break;
			}
		}

		if (!bookExists) {
			// Sách chưa có trong giỏ hàng, thêm vào
			cartItems.add(cartItem);
		}
	}

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public double calculateTotalPrice() {
		double totalPrice = 0.0;
		for (CartItem cartItem : cartItems) {
			double bookPrice = cartItem.getBook().getPrice();
			totalPrice += bookPrice;
		}
		return totalPrice;
	}

	public void clearCart() {
	    cartItems.clear();
	}
	
	public boolean checkIfBookExists(String bookId) {
		for (CartItem cartItem : cartItems) {
			if (cartItem.getBook().getBookid().equals(bookId)) {
				return true;
			}
		}
		return false;
	}
	
	public void addCartItem(CartItem cartItem) {
	    if (cartItems == null) {
	        cartItems = new ArrayList<>();
	    }
	    
	    // Kiểm tra xem sách đã tồn tại trong giỏ hàng hay chưa
	    for (CartItem item : cartItems) {
	        if (item.getBook().getBookid().equals(cartItem.getBook().getBookid())) {
	            // Sách đã tồn tại trong giỏ hàng, tăng số lượng
	            item.setQuantity(item.getQuantity() + cartItem.getQuantity());
	            return;
	        }
	    }
	    
	    // Sách chưa tồn tại trong giỏ hàng, thêm mới
	    cartItems.add(cartItem);
	}



}
