import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/cart_att.dart';
import 'package:flutter_ecommerce/models/favorite_att.dart';
import 'package:flutter_ecommerce/views/widgets/drop_down_menu.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../controller/dataase_controller.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../utilities/const.dart';
import '../widgets/main_dialog.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;
  late String dropdownValueSize;
  late String dropdownValueColor;
  late int dropdownValueQ;

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = CartAtt(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price.toInt(),
        size: dropdownValueSize,
        imgUrl: widget.product.imgUrl,
        discountValue: widget.product.discountValue,
        productId: widget.product.id,
        color: dropdownValueColor,
        // quantity: dropdownValueQ.toInt(),
      );
      await database.addToCart(addToCartProduct);
      Navigator.pop(context);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t add to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  Future<void> _addToFav(Database database) async {
    try {
      final addToFavProduct = FavoriteAtt(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        size: dropdownValueSize,
        imgUrl: widget.product.imgUrl,
        discountValue: widget.product.discountValue,
        productId: widget.product.id,
        color: dropdownValueColor,
        // quantity: dropdownValueQ.toInt(),
      );
      await database.addToFavorite(addToFavProduct);
      //Navigator.pop(context);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t add to the fav, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    widget.product.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            Image.network(
              widget.product.imgUrl,
              height: size.height * 0.5,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DropDownMenuComponent(
                          items: const ['S', 'M', 'L', 'XL', 'XXL'],
                          hint: 'Size',
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueSize = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: DropDownMenuComponent(
                          items: const ['Black', 'Red', 'White'],
                          hint: 'Color',
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueColor = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      /* Expanded(
                        flex: 1,
                        child: DropDownMenuComponent(
                          items: const [
                            '1',
                            '2',
                            '3',
                            '4',
                          ],
                          hint: 'Quantity',
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueQ = newValue! as int;
                            });
                          },
                        ),
                      ),*/
                      const SizedBox(width: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            onTap: () => _addToFav(database),
                            // isFavorite = !isFavorite;

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
                                  color: isFavorite
                                      ? Colors.redAccent
                                      : Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product.title,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Text(
                        (widget.product.discountValue == 0)
                            ? ' \$${widget.product.price.toString()}'
                            : '\$${widget.product.price - (widget.product.price * (widget.product.discountValue / 100))}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.category,
                    style: TextStyle(
                      color: Colors.grey.withOpacity(1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(database),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        'Add to cart',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
