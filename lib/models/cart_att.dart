import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartAtt {
  final String id;
  final String productId;
  final String title;
  final int price;
  int quantity;
  final String imgUrl;
  final int discountValue;
  final String color;
  final String size;

  CartAtt({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    this.quantity = 1,
    required this.imgUrl,
    this.discountValue = 0,
    this.color = 'Black',
    required this.size,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'discountValue': discountValue});
    result.addAll({'color': color});
    result.addAll({'size': size});

    return result;
  }

  factory CartAtt.fromMap(Map<String, dynamic> map, String documentId) {
    return CartAtt(
      id: documentId,
      title: map['title'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discountValue: map['discountValue']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
    );
  }

  /*
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String imageUrl;
  final String size;
  final String productId;
  final int discountValue;
  final String color;

  CartAtt({
    required this.productId,
    this.color = 'black',
    required this.size,
    required this.discountValue,
    required this.id,
    required this.title,
    this.quantity = 1,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'imgUrl': imageUrl});
    result.addAll({'productId': productId});
    result.addAll({'discountValue': discountValue});
    result.addAll({'size': size});
    result.addAll({'color': color});

    return result;
  }

  factory CartAtt.fromMap(Map<String, dynamic> map, String documentId) {
    return CartAtt(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      productId: map['productId'] as String,
      discountValue: map['discountValue'] as int,
      size: map['size'] as String,
      color: map['color'] as String,
    );
  }*/
}
