import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/widgets/error_page.dart';
import 'package:twitter_clone/config/theme/theme.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/features/splash/view/splash_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      routes: {
        LoginView.routeName: (context) => const LoginView(),
        SignUpView.routeName: (context) => const SignUpView(),
      },
      home:
      ref.watch(currentUserAccountProvider).when(
        data: (user) {
          if (user != null) {
            return const HomeView();
          }
          return const SignUpView();
        },
        error: (error, stackTrace) {
          return ErrorPage(errorMessage: error.toString());
        },
        loading: () {
          return const SplashView();
        },
      ),
    );
  }
}
