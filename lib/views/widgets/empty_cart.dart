import 'package:flutter/material.dart';

class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 90),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  //Image.network
                  'https://firebasestorage.googleapis.com/v0/b/flutter-ecommerce-fac6f.appspot.com/o/emptycart.png?alt=media&token=e7c6bdf7-2c95-4fb0-acdc-079309434466',
                ),
              ),
            ),
          ),
          const Text(
            'Your Cart is Empty',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
