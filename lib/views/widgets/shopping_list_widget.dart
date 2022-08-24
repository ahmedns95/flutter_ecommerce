import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/dataase_controller.dart';
import '../../models/product.dart';
import '../../utilities/routes.dart';

class SoppingListWidget extends StatelessWidget {
  const SoppingListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Product products;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.detailsPageRoutes, arguments: {
            'product': products,
            'database': database,
          });
        },
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
                  Text(
                    products.category,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(children: [
                      (products.discountValue > 0)
                          ? TextSpan(
                              text: '\$${products.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
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
      ),
    );
  }
}
