import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/pages/account_page.dart';
import 'package:flutter_ecommerce/views/pages/cart_page.dart';
import 'package:flutter_ecommerce/views/pages/home_page.dart';
import 'package:flutter_ecommerce/views/pages/shopping_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'favorite_page.dart';

class bottomNavbar extends StatefulWidget {
  const bottomNavbar({Key? key}) : super(key: key);

  @override
  State<bottomNavbar> createState() => _bottomNavbarState();
}

class _bottomNavbarState extends State<bottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final _controller = PersistentTabController();
    List<Widget> _buildScreens() {
      return [
        const HomePage(),
        const ShoppingPage(),
        const CartPage(),
        const FavoritePage(),
        const AccountPage(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ('Home'),
          activeColorPrimary: Color(0xFFDB3022),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.bag_fill),
          title: ("shop"),
          activeColorPrimary: Color(0xFFDB3022),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.shopping_cart),
          title: ("cart"),
          activeColorPrimary: Color(0xFFDB3022),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.heart_fill),
          title: ("Favorite"),
          activeColorPrimary: Color(0xFFDB3022),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: ("Profile"),
          activeColorPrimary: Color(0xFFDB3022),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 100),
      ),
      navBarStyle:
          NavBarStyle.style11, // Choose the nav bar style with this property.
    ));
  }
}
