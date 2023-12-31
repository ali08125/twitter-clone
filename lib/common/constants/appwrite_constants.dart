class AppwriteConstants {
  static const databaseId = '653b4cce49b1ee88b687';
  static const projectId = '653b47cab0307b6ed8af';
  static const endPoint = 'https://cloud.appwrite.io/v1';
  static const usersCollectionId = '653dfc460587734882fd';
  static const tweetsCollectionId = '654129725acd798f326b';
  static const imagesBucketId = '654136728510fe653152';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucketId/files/$imageId/view?project=$projectId&mode=admin';
}
