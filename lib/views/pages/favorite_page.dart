import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/models/favorite_att.dart';
import 'package:flutter_ecommerce/views/widgets/cart_item.dart';
import 'package:flutter_ecommerce/views/widgets/list_item_home.dart';
import 'package:provider/provider.dart';

import '../widgets/fav_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: 530,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            StreamBuilder<List<FavoriteAtt>>(
              stream: database.favoriteProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final products = snapshot.data;
                  if (products == null || products.isEmpty) {
                    return const Center(
                      child: Text('Favorite iS Empty'),
                    );
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
