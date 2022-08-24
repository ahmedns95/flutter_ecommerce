import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/views/pages/details_page.dart';
import 'package:provider/provider.dart';
import '../../controller/dataase_controller.dart';
import '../../models/cart_att.dart';
import '../../utilities/const.dart';
import 'main_dialog.dart';

class CartItem extends StatefulWidget with ChangeNotifier {
  final CartAtt product;
  CartItem({Key? key, required this.product}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

/*final CollectionReference _products =
    FirebaseFirestore.instance.collection('addToCart');
Future<void> _delete(String productId) async {
  await _products.doc(productId).delete();
}*/

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final Size size = MediaQuery.of(context).size;
    Future<void> _deleteFromCart(Database database) async {
      try {
        final addToCartProduct = CartAtt(
          id: documentIdFromLocalData(),
          title: widget.product.title,
          price: widget.product.price.toInt(),
          size: '',
          imgUrl: widget.product.imgUrl,
          discountValue: widget.product.discountValue,
          productId: widget.product.id,
          color: '',
          quantity: 1,
          // quantity: dropdownValueQ.toInt(),
        );

        await database.deleteFromCart(addToCartProduct);
      } catch (e) {
        return MainDialog(
          context: context,
          title: 'Error',
          content:
              'Couldn\'t add to the cart, please try again!${e.toString()}',
        ).showAlertDialog();
      }
    }

    return Column(
      children: [
        Container(
          height: size.height * 0.14,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 90,
                height: size.height * 0.12,
                child: Image.network(
                  widget.product.imgUrl,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          widget.product.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              _deleteFromCart(database);
                            },
                            icon: const Icon(Icons.delete_forever)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Color: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.product.color),
                        const SizedBox(width: 10),
                        const Text(
                          'Size: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.product.size),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          focusColor: Colors.black,
                          onPressed: () {
                            StreamBuilder<List<CartAtt>>(
                              stream: database.cartProduct(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  final cartProducts =
                                      snapshot.data as List<CartAtt>;
                                  if (cartProducts.isEmpty) {
                                    return const Center(
                                      child: Text(''),
                                    );
                                  }
                                  return Text(
                                    '\$${cartProducts.isEmpty ? cartProducts.map<int>((e) => e.quantity++) : 0}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            );
                            setState(() {
                              widget.product.quantity--;
                            });
/*
                              _cartProvider.reductCartItem(
                            productId,
                            _cartAttr.price,
                            _cartAttr.title,
                            _cartAttr.imageUrl); */
                          },
                          icon: const Icon(
                            CupertinoIcons.minus,
                            size: 20,
                          ),
                        ),
                        Card(
                          child: Container(
                            width: 40,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                widget.product.quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          focusColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget.product.quantity++;
                            });
                            /*      _cartProvider.addProductToCart(
                            productId,
                            _cartAttr.price,
                            _cartAttr.title,
                            _cartAttr.imageUrl); */
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            '${(widget.product.price - (widget.product.price * (widget.product.discountValue / 100))) * widget.product.quantity}\$',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //SizedBox(width: 50),
              /* Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Text(
                    '${(widget.product.price - (widget.product.price * (widget.product.discountValue / 100))) * widget.product.quantity}\$',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )*/
            ],
          ),
        ),
        SizedBox(height: size.height * .01),
      ],
    );
  }
}
