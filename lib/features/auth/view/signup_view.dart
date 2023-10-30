import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/constants/constants.dart';
import 'package:twitter_clone/common/widgets/custom_snackbar.dart';
import 'package:twitter_clone/common/widgets/rounded_small_button.dart';
import 'package:twitter_clone/config/theme/theme.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  static const routeName = '/signup_view';

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController(text: '12345678');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    if (emailController.text != '' && passwordController.text != '') {
      ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    } else {
      showSnackbar(context, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
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
                  hintText: 'Email address',
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
                    onTap: onSignUp,
                    label: 'Sign up',
                    backgroundColor: Pallete.blueColor,
                    textColor: Pallete.whiteColor,
                    isLoading: isLoading,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // text span
                RichText(
                    text: TextSpan(
                        text: 'Already have an account?',
                        style: const TextStyle(fontSize: 14),
                        children: [
                      TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                              color: Pallete.blueColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, LoginView.routeName);
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
