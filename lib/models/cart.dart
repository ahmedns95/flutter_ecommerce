import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:provider/provider.dart';

import '../controller/dataase_controller.dart';

class Cart with ChangeNotifier {
  Map<String, CartAtt> _cartItems = {};

  int price = 00;
  Map<String, CartAtt> get getCartItem {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 10.0;

    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  void addProductToCart(
      String productId, int price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      //to check if the cart already has the item with the the same key
      _cartItems.update(
        productId,
        (extingCartItem) => CartAtt(
          id: extingCartItem.id,
          title: extingCartItem.title,
          price: extingCartItem.price,
          quantity: extingCartItem.quantity + 1,
          imgUrl: extingCartItem.imgUrl,
          size: '',
          discountValue: 3,
          productId: '',
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAtt(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          size: '',
          discountValue: 2,
          productId: '',
          imgUrl: '',
        ),
      );
    }
  }

  void reductCartItem(
      String productId, double price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(productId, (exitingCartItem) {
        return CartAtt(
            id: exitingCartItem.id,
            title: exitingCartItem.title,
            quantity: exitingCartItem.quantity - 1,
            price: exitingCartItem.price,
            discountValue: 2,
            size: '',
            productId: '',
            imgUrl: exitingCartItem.imgUrl);
      });
    }
  }
}
