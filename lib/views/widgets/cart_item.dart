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
    final database = Provider.of<Database>(context);

    //  int subtotal = _cartAttr.price * _cartAttr.quantity;
    return Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                height: 160,
                child: Image.network(
                  widget.product.imgUrl,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
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
                            deletFromCart(database);
                            /* _cartProvider.reductCartItem(
                            productId,
                            _cartAttr.price,
                            _cartAttr.title,
                            _cartAttr.imageUrl);*/
                          },
                          icon: const Icon(
                            CupertinoIcons.minus,
                            size: 25,
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            width: 40,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            //  product.quantity ++;
                            /*_cartProvider.addProductToCart(
                            productId,
                            _cartAttr.price,
                            _cartAttr.title,
                            _cartAttr.imageUrl);*/
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //SizedBox(width: 50),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50),
                child: Text(
                  '${widget.product.price}\$',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 6,
        )
      ],
    );
  }
}
