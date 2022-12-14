import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/controller/dataase_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/pages/buttom_navbar.dart';
import 'package:flutter_ecommerce/views/pages/cart_page.dart';
import 'package:flutter_ecommerce/views/pages/details_page.dart';
import 'package:flutter_ecommerce/views/pages/landing_page.dart';
import 'package:flutter_ecommerce/views/pages/auth_page.dart';
import 'package:flutter_ecommerce/views/pages/shopping_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecommerce/views/pages/checkout_page.dart';

Route<dynamic> onGenerate(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.loginPageRoutes:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: setting,
      );
    case AppRoutes.buttomNavBarPageRoutes:
      return CupertinoPageRoute(
        builder: (_) => const bottomNavbar(),
        settings: setting,
      );

    case AppRoutes.checkoutPageRoutes:
      final database = setting.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
            value: database, child: const ChckoutPage()),
        settings: setting,
      );

    case AppRoutes.detailsPageRoutes:
      final args = setting.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: DetailsPage(product: product),
        ),
        settings: setting,
      );

    case AppRoutes.ShoppingPageRoutes:
      final args = setting.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          // child: const ShoppingPage(),
        ),
        settings: setting,
      );

    case AppRoutes.landingPageRoutes:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: setting,
      );
  }
}
