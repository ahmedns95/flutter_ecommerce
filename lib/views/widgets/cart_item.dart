import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/views/pages/details_page.dart';
import 'package:provider/provider.dart';
import '../../controller/dataase_controller.dart';
import '../../models/cart_att.dart';
import '../../utilities/const.dart';
import 'main_dialog.dart';

class CartItem extends StatefulWidget {
  final CartAtt product;
  const CartItem({Key? key, required this.product}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Future<void> deletFromCart(Database database) async {
    try {
      final addToCartProduct = CartAtt(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price.toInt(),
        size: 'M',
        imgUrl: widget.product.imgUrl,
        discountValue: widget.product.discountValue,
        productId: widget.product.id,
        color: 'Black',
        // quantity: dropdownValueQ.toInt(),
      );
      await database.deleteFromCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t add to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _cartAttr = Provider.of<CartAtt>(context);
    // final database = Provider.of<Database>(context);
    // int subtotal = _cartAttr.price * _cartAttr.quantity;
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.12,
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
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    // const SizedBox(height: 8),
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
                          onPressed: () {
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
                      ],
                    ),
                  ],
                ),
              ),
              //SizedBox(width: 50),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  '${widget.product.price * widget.product.quantity}\$',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: size.height * .01),
      ],
    );
  }
}
