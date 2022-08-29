import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/views/widgets/cart_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../utilities/routes.dart';
import '../widgets/empty_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myProducts =
        await Provider.of<Database>(context, listen: false).cartProduct().first;
    for (var element in myProducts) {
      setState(() {
        totalAmount += element.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    Size size = MediaQuery.of(context).size;
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
                    final cartProducts = snapshot.data;
                    if (cartProducts == null || cartProducts.isEmpty) {
                      return const Center(
                          child: CartEmpty(
                        title: 'Your Cart is Empty',
                      ));
                    }

                    return ListView.builder(
                      //shrinkWrap: false,
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.vertical,
                      itemCount: cartProducts.length,
                      itemBuilder: (_, index) {
                        return CartItem(product: cartProducts[index]);
                      },
                    );
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
                      Center(
                        child: Text(
                          '\$${totalAmount.toString()}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                      /* Text(
                        '\$${cart.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),*/
                    ],
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Center(
                    child: MainButton(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.checkoutPageRoutes,
                          arguments: database,
                        );
                      },
                      text: 'CHECK OUT',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
