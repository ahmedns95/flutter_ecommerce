import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import '../../utilities/assets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, model, __) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.search),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Image.network(
                        AppAssets.profilePicture,
                      ),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ali Khaled',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          /*model.email.isEmpty
                              ? "info@hotmail.com"
                              : */
                          model.email.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileOptionsWidget(
                  leading: 'My orders',
                  title: 'Already have 12 options',
                  onTap: () {},
                ),
                const DividerWidget(),
                ProfileOptionsWidget(
                  leading: 'Shipping addresses',
                  title: '3 addresses',
                  onTap: () {},
                ),
                const DividerWidget(),
                ProfileOptionsWidget(
                  leading: 'Payment methods',
                  title: 'Visa **34',
                  onTap: () {},
                ),
                const DividerWidget(),
                ProfileOptionsWidget(
                  leading: 'Promo codes',
                  title: 'You have special promo code',
                  onTap: () {},
                ),
                const DividerWidget(),
                ProfileOptionsWidget(
                  leading: 'My reviews',
                  title: 'Reviews for 4 items',
                  onTap: () {},
                ),
                const DividerWidget(),
                ProfileOptionsWidget(
                  leading: 'Settings',
                  title: 'Notifications, password',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            MainButton(
                text: "Log out",
                onTap: () {
                  _logout(model, context);
                }),
          ],
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: Colors.grey.shade300,
    );
  }
}

class ProfileOptionsWidget extends StatelessWidget {
  final String title;
  final String leading;
  final VoidCallback onTap;
  const ProfileOptionsWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leading,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 15),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          color: Colors.grey,
          onPressed: onTap,
        ),
      ],
    );
  }
}
