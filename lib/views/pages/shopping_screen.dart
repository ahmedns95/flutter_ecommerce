import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/category_att.dart';
import 'package:provider/provider.dart';

import '../../controller/dataase_controller.dart';
import '../../models/product.dart';
import '../widgets/category_widget.dart';
import '../widgets/list_item_home.dart';
import '../widgets/shopping_list_widget.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    Size size = MediaQuery.of(context).size;
    bool isEnable = false;
    CategoryAtt categoryAtt;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Men Clothes',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * .019),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  const Spacer(),
                  CategoryWidget(
                    onTap: () {
                      setState(() {
                        isEnable = true;
                      });
                    },
                    size: size,
                    title: 'Jackets',
                  ),
                  const Spacer(),
                  CategoryWidget(
                    onTap: () {
                      setState(() {});
                    },
                    size: size,
                    title: 'T-Shirts',
                  ),
                  const Spacer(),
                  CategoryWidget(
                    onTap: () {
                      setState(() {
                        CategoryAtt.shirts;
                      });
                    },
                    size: size,
                    title: 'Pants',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 600,
              child: StreamBuilder<List<Product>>(
                stream: database.jacketCateg(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      (isEnable == false)) {
                    final products = snapshot.data;
                    if (products == null || products.isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          SoppingListWidget(products: products[index]),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            /*SizedBox(
              height: 300,
              child: StreamBuilder<List<Product>>(
                stream: database.shirtCateg(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final products = snapshot.data;
                    if (products == null || products.isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                    //  querySelector('shirts');
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          SoppingListWidget(products: products[index]),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
