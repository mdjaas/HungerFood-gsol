import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartItems = [];

  int getQuantity(String documentId) {
    int index = cartItems.indexWhere((item) => item.documentId == documentId);
    return index != -1 ? cartItems[index].qty ?? 0 : 0;
  }

  Future<void> addToCart(String documentId, String title, int qty, String price, String image) async {
    try {
      int existingIndex = cartItems.indexWhere((item) => item.documentId == documentId);

      if (existingIndex != -1) {
        // Check if qty is null and initialize it
        if (cartItems[existingIndex].qty != null) {
          cartItems[existingIndex].qty += qty;
        } else {
          cartItems[existingIndex].qty = qty;
        }
      } else {
        cartItems.add(CartModel(documentId: documentId, title: title, qty: qty, price: price, image: image));
      }

      notifyListeners();
    } catch (error) {
      print("Error adding to cart: $error");
    }
  }

  Future<void> removeFromCart(String documentId) async {
    try {
      int indexToRemove = cartItems.indexWhere((item) => item.documentId == documentId);

      if (indexToRemove != -1) {
        cartItems.removeAt(indexToRemove);
        notifyListeners();
      }
    } catch (error) {
      print("Error removing from cart: $error");
    }
  }

  Future<void> reduceQuantity(String documentId) async {
    try {
      int indexToDecrement = cartItems.indexWhere((item) => item.documentId == documentId);

      if (indexToDecrement != -1) {
        if (cartItems[indexToDecrement].qty != null && cartItems[indexToDecrement].qty! > 0) {
          cartItems[indexToDecrement].qty -= 1;
          notifyListeners();
        }
      }
    } catch (error) {
      print("Error decrementing quantity: $error");
    }
  }
}
