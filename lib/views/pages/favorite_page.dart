import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/favorite_att.dart';
import 'package:provider/provider.dart';

import '../widgets/category_widget.dart';
import '../widgets/empty_cart.dart';
import '../widgets/fav_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 20,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 30,
                    offset: Offset(6, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      //   Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            Text(
              ' Favorite',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(height: size.height * .03),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: size.width * .02),
                  CategoryWidget(
                    onTap: () {},
                    size: size,
                    title: 'Jackets',
                  ),
                  SizedBox(width: size.width * .02),
                  CategoryWidget(
                    onTap: () {},
                    size: size,
                    title: 'Jackets',
                  ),
                  SizedBox(width: size.width * .02),
                  CategoryWidget(
                    onTap: () {},
                    size: size,
                    title: 'T-Shirts',
                  ),
                  SizedBox(width: size.width * .02),
                  CategoryWidget(
                    onTap: () {},
                    size: size,
                    title: 'Pants',
                  ),
                ],
              ),
            ),
            StreamBuilder<List<FavoriteAtt>>(
              stream: database.favoriteProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final products = snapshot.data;
                  if (products == null || products.isEmpty) {
                    return const Center(
                        child: CartEmpty(
                      title: 'Your Favorite is Empty',
                    ));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => FavListWidget(
                      products: products[index],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
