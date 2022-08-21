import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/models/favorite_att.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';
import '../models/category_att.dart';
import '../models/delivery_method.dart';
import '../models/user_model.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<CartAtt>> cartProduct();
  Stream<List<FavoriteAtt>> favoriteProduct();
  Stream<List<DeliveryMethod>> deliveryMethodsStream();
  Stream<List<Product>> jacketCateg();
  Stream<List<Product>> pantsCateg();
  Stream<List<Product>> shirtCateg();
  Future<void> setUserData(User user);
  Future<void> addToCart(CartAtt cart);
  Future<void> deleteFromCart(CartAtt cart);
  Future<void> addToFavorite(FavoriteAtt fav);
  void printUid();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance; //services/fireStoreService
  FirestoreDatabase(this.uid);
  CategoryAtt? _categoryAtt;

  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isEqualTo: 0),
      );

  @override
  Stream<List<Product>> jacketCateg() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) =>
            query.where('category', isEqualTo: _categoryAtt),
      );

  @override
  Stream<List<Product>> shirtCateg() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('category', isEqualTo: 'shirt'),
      );

  @override
  Stream<List<Product>> pantsCateg() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('category', isEqualTo: 'pant'),
      );
//if customer wants to add data
  Future<void> setProduct(Product product) async => _service.setData(
        path: 'products/${product.id}',
        data: product.toMap(),
      );

  @override
  Future<void> setUserData(User user) async => await _service.setData(
        path: ApiPath.user(user.uid),
        data: user.toMap(),
      );

  @override
  Future<void> addToCart(CartAtt cart) async => _service.setData(
        path: ApiPath.addToCart(uid, cart.id),
        data: cart.toMap(),
      );

  @override
  Future<void> deleteFromCart(CartAtt cart) async => _service.deleteData(
        path: ApiPath.deletFromCart(uid, cart.id),
        data: cart.toMap(),
      );

  //Stream - It can deliver one or more value
  @override
  Stream<List<CartAtt>> cartProduct() => _service.collectionsStream(
        path: ApiPath.myCartProduct(uid),
        builder: (data, documentId) => CartAtt.fromMap(data!, documentId),
      );

  @override
  Future<void> addToFavorite(FavoriteAtt fav) async => _service.setData(
        path: ApiPath.addToFav(uid, fav.id),
        data: fav.toMap(),
      );

  @override
  void printUid() {
    debugPrint('Generated id:  $uid');
  }

  @override
  Stream<List<FavoriteAtt>> favoriteProduct() => _service.collectionsStream(
        path: ApiPath.myFavProduct(uid),
        builder: (data, documentId) => FavoriteAtt.fromMap(data!, documentId),
      );
  @override
  Stream<List<DeliveryMethod>> deliveryMethodsStream() =>
      _service.collectionsStream(
          path: ApiPath.deliveryMethods(),
          builder: (data, documentId) =>
              DeliveryMethod.fromMap(data!, documentId));
}
