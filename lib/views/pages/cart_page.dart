import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/views/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../widgets/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);
  void removeAtIndex(int index, Map<String, CartAtt> cart) {
    for (int i = 0; i < cart.length; i++) {
      //cart[index].
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final CartAtt cart;
    double total = 0;
    Size size = MediaQuery.of(context).size;
    // final database = Provider.of<Database>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),
            const SizedBox(
              child: Text(
                'My Bag',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: size.height * .6,
              child: StreamBuilder<List<CartAtt>>(
                stream: database.cartProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final product = snapshot.data;
                    if (product == null || product.isEmpty) {
                      return Center(child: CartEmpty());
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: product.length,
                        itemBuilder: (_, index) {
                          total += (product[index].price *
                              (product[index].price * product[index].quantity));
                          return CartItem(product: product[index]);
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 20,
                    blurRadius: 150,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Total amount: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$$total',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Center(
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                            height: 50,
                            width: 300,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: const Center(
                              child: Text(
                                'CHECK OUT',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
