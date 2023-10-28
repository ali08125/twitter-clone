import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/providers/providers.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

abstract class IAuthAPI {
  Future<DataState> signUp({required String email, required String password});

  Future<DataState> login({required String email, required String password});
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  const AuthAPI({
    required Account account,
  }) : _account = account;

  @override
  Future<DataState> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return DataSuccess(account);
    } on AppwriteException catch (e) {
      return DataFailed(e.message ?? 'Error');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return DataSuccess(session);
    } on AppwriteException catch (e) {
      return DataFailed(e.message ?? 'Error');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
