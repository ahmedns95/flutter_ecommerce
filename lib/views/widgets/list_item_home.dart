import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/assets.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

import '../../controller/dataase_controller.dart';
import '../pages/details_page.dart';

class ListItemHome extends StatelessWidget {
  final Product product;
  const ListItemHome({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    final database = Provider.of<Database>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(AppRoutes.detailsPageRoutes, arguments: {
          'product': product,
          'database': database,
        });
      },
      //
      child: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    product.imgUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 5,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isFavorite ? Colors.redAccent : Colors.black45,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (product.discountValue > 0)
                      ? SizedBox(
                          width: 50,
                          height: 25,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  '${product.discountValue}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 50,
                          height: 25,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  'NEW',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              product.category,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 6.0),
            Text(
              product.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 6.0),
            Text.rich(
              TextSpan(children: [
                (product.discountValue > 0)
                    ? TextSpan(
                        text: '${product.price}\$',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                      )
                    : const TextSpan(),
                TextSpan(
                    text:
                        '  ${product.price - (product.price * (product.discountValue / 100))}\$')
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
