import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ewitter_app/src/common/constants/constants.dart';

class KAppwrite {
  // Checks if the required environment variables are available in the .env file!
  static bool checkEnvVariables() {
    List<String> envKeys = [
      KApp.keyAppwriteEndPoint,
      KApp.keyAppwriteProjectId,
      KApp.keyAppWriteDatabaseId,
      KApp.keyAppwriteUsersCollectionId,
      KApp.keyAppwriteEweetCollectionId,
      KApp.keyAppwriteImageBucket,
    ];

    for (int i = 0; i < envKeys.length; i++) {
      if (dotenv.env[envKeys[i]] == null) {
        return false;
      }
    }

    return true;
  }

  static String baseEndPointUrl = dotenv.env[KApp.keyAppwriteEndPoint]!;
  static String projectId = dotenv.env[KApp.keyAppwriteProjectId]!;
  static String databaseId = dotenv.env[KApp.keyAppWriteDatabaseId]!;
  static String usersCollectionId =
      dotenv.env[KApp.keyAppwriteUsersCollectionId]!;
  static String eweetsCollection =
      dotenv.env[KApp.keyAppwriteEweetCollectionId]!;
  static String imagesBucket = dotenv.env[KApp.keyAppwriteImageBucket]!;
  static String imageUrl(String imageId) =>
      '$baseEndPointUrl/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
