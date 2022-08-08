import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controller/auth_controller.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title:
                    Text('Error', style: Theme.of(context).textTheme.headline5),
                content: Text(e.toString(),
                    style: Theme.of(context).textTheme.subtitle2),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // auth controller is the provider of the context used to get the information form the auth base
    return Consumer<AuthController>(builder: (_, model, __) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 46.0, horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 320.0,
                          child: TextLiquidFill(
                            text: 'Street Clothes',
                            waveColor: Colors.blueAccent,
                            boxBackgroundColor: Colors.redAccent,
                            textStyle: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                            boxHeight: 100,
                          ),
                        ),
                        /*  TypewriterAnimatedTextKit(
                          text: [],
                          textStyle: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                      ],
                    ),
                    Text(
                        model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 80.0),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      onChanged: model.updateEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter email' : null,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                    ),
                    const SizedBox(height: 17.0),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      onChanged: model.updatePassword,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter password' : null,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'Enter your your password',
                      ),
                    ),
                    const SizedBox(height: 17.0),
                    if (model.authFormType == AuthFormType.login)
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text('Forget your password'),
                          onTap: () {},
                        ),
                      ),
                    const SizedBox(height: 17.0),
                    MainButton(
                      //this would check if its gets the email and password
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submit(model);
                        }
                      },
                      text: model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text(model.authFormType == AuthFormType.login
                            ? 'Don\'t have an account? Register'
                            : 'Have an account? login'),
                        onTap: () {
                          _formKey.currentState!.reset();
                          model.toogleFormType();
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.09),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        model.authFormType == AuthFormType.login
                            ? 'Or login with'
                            : 'Or register with',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 20.0),
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
