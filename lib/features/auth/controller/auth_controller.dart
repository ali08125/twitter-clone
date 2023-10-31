// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/apis/auth_api.dart';
import 'package:twitter_clone/common/apis/user_api.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/utils/utils.dart';
import 'package:twitter_clone/common/widgets/custom_snackbar.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    ref.watch(authAPIProvider),
    ref.watch(userAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.currentUser();
  },
);

final currentUserDetailsProvider = FutureProvider((ref) {
  final result = ref.watch(currentUserAccountProvider);
  final currentUserId = result.value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController(AuthAPI authAPI, UserAPI userAPI)
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  // state = isLoading

  currentUser() async {
    final user = await _authAPI.currentUserAccount();
    if (user is DataSuccess) {
      return user.data;
    }
  }

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.signUp(email: email, password: password);
    if (result is DataSuccess) {
      state = false;
      final UserModel userModel = UserModel(
          name: getNameFromEmail(email),
          email: email,
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: result.data.$id,
          bio: '',
          isTwitterBlue: false);
      final res = await _userAPI.saveUserData(userModel);
      if (res is DataFailed) {
        showSnackbar(
            context, res.error ?? 'Error saving user data to database');
      } else {
        showSnackbar(context, 'Account created! Please login');
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
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

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    return UserModel.fromMap(document.data);
  }
}
