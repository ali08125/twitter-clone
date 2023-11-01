
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/constants/appwrite_constants.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/providers/providers.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetAPIProvider = Provider((ref) {
  return TweetAPI(databases: ref.watch(appwriteDatabaseProvider));
});

abstract class ITweetAPI {
  Future<DataState> shareTweet(Tweet tweet);

  Future<List<Document>> getTweets();
}

class TweetAPI implements ITweetAPI {
  final Databases _databases;

  const TweetAPI({
    required Databases databases,
  }) : _databases = databases;

  @override
  Future<DataState> shareTweet(Tweet tweet) async {
    try {
      final document = await _databases.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollectionId,
          documentId: ID.unique(),
          data: tweet.toMap());
      return DataSuccess(document);
    } on AppwriteException catch (e) {
      return DataFailed(e.message ?? 'Error');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<List<Document>> getTweets() async {
    final result = await _databases.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.tweetsCollectionId,
    );
    return result.documents;
  }
}
