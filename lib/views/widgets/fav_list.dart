import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/favorite_att.dart';

import '../../models/product.dart';

class FavListWidget extends StatelessWidget {
  const FavListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final FavoriteAtt products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
            borderRadius: const BorderRadius.all(Radius.circular(18))),
        //     color: Colors.white,
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  //color: Colors.grey.shade300,
                  width: 90,
                  height: 100,
                  child: Image.network(
                    products.imgUrl,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(children: [
                    (products.discountValue > 0)
                        ? TextSpan(
                            text: '\$${products.price}',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          )
                        : const TextSpan(),
                    TextSpan(
                        text:
                            ' \$${products.price - (products.price * (products.discountValue / 100))}')
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
