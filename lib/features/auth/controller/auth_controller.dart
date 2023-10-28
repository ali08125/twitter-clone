import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/apis/auth_api.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/utils/custom_snackbar.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController(AuthAPI authAPI)
      : _authAPI = authAPI,
        super(false);

  // state = isLoading

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.signUp(email: email, password: password);
    if (result is DataSuccess) {
      state = false;
    } else {
      // ignore: use_build_context_synchronously
      showSnackbar(context, result.error ?? 'Unknown error');
      state = false;
    }
  }
}
