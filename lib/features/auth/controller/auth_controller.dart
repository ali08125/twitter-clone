// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/apis/auth_api.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/utils/custom_snackbar.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref.watch(authAPIProvider));
});

final currentUserAccountProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.currentUser();
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController(AuthAPI authAPI)
      : _authAPI = authAPI,
        super(false);

  // state = isLoading

  currentUser() => _authAPI.currentUserAccount();

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.signUp(email: email, password: password);
    if (result is DataSuccess) {
      state = false;
      showSnackbar(context, 'Account created! Please login');
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    } else {
      showSnackbar(context, result.error ?? 'Unknown error');
      state = false;
    }
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.login(email: email, password: password);
    if (result is DataSuccess) {
      state = false;
      Navigator.pushReplacement(context, HomeView.route());
    } else {
      showSnackbar(context, result.error ?? 'Unknown error');
      state = false;
    }
  }
}
