import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/common/constants/constants.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/providers/providers.dart';
import 'package:twitter_clone/models/user_model.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    databases: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IUserAPI {
  Future<DataState> saveUserData(UserModel userModel);

  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _databases;

  const UserAPI({
    required Databases databases,
  }) : _databases = databases;

  @override
  Future<DataState> saveUserData(UserModel userModel) async {
    try {
      await _databases.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return DataSuccess(null);
    } on AppwriteException catch (e) {
      return DataFailed(e.message ?? 'Error');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        documentId: uid);
  }
}
