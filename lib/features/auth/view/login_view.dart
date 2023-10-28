import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/constants/constants.dart';
import 'package:twitter_clone/common/widgets/rounded_small_button.dart';
import 'package:twitter_clone/config/theme/theme.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/login_view';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // email field
                AuthField(
                  controller: emailController,
                  hintText: 'Email adress',
                ),
                const SizedBox(
                  height: 25,
                ),

                // password field
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 25,
                ),

                // button
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: () {},
                    label: 'Login',
                    backgroundColor: Pallete.blueColor,
                    textColor: Pallete.whiteColor,
                    isLoading: false,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // text span
                RichText(
                    text: TextSpan(
                        text: 'Dont\s have an account?',
                        style: const TextStyle(fontSize: 14),
                        children: [
                      TextSpan(
                          text: ' Sign up',
                          style: const TextStyle(
                              color: Pallete.blueColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpView.routeName);
                            })
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
