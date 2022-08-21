import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/assets.dart';
import 'package:flutter_ecommerce/views/pages/shopping_screen.dart';
import 'package:flutter_ecommerce/views/widgets/list_item_home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecommerce/views/widgets/build_header_list.dart';

import '../../utilities/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /// TODO: Temp code till refactor to a separate class with a separate context

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          /*Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: TypewriterAnimatedTextKit(
                  text: const ['Street Clothes'],
                  speed: const Duration(milliseconds: 50),
                  textStyle: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                */ /* Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),*/ /*
              ),
            ],
          ),*/
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                BuildHeaderOfList(
                  context: context,
                  title: 'Sale',
                  description: 'Super Summer Sale !!',
                  onTap: () {},
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                    stream: database.salesProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;
                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text('No data available'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListItemHome(product: products[index]),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                BuildHeaderOfList(
                  title: 'New',
                  description: 'Super New Products!!',
                  context: context,
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.ShoppingPageRoutes);
                  },
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                    stream: database.newProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;
                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text('No data available'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListItemHome(product: products[index]),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
