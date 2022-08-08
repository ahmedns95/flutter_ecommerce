import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';

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
      builder: (_, model, __) => Column(
        children: [
          const Spacer(),
          const Icon(
            Icons.person,
            size: 60,
            color: Colors.redAccent,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: MainButton(
                text: 'Log Out',
                onTap: () {
                  _logout(model, context);
                }),
          )
        ],
      ),
    );
  }
}
