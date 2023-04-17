import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ewitter_app/src/constants/constants.dart';

class KAppWrite {
  // Checks if the required environment variables are available in the .env file!
  static bool checkEnvVariables() {
    List<String> envKeys = [
      KApp.keyAppWriteEndPoint,
      KApp.keyAppWriteProjectId,
      KApp.keyAppWriteDatabaseId,
      KApp.keyAppWriteUsersCollectionId,
      KApp.keyAppWriteEweetCollectionId,
      KApp.keyAppWriteImageBucket,
    ];

    for (int i = 0; i < envKeys.length; i++) {
      if (dotenv.env[envKeys[i]] == null) {
        return false;
      }
    }

    return true;
  }

  static String baseEndPointUrl = dotenv.env[KApp.keyAppWriteEndPoint]!;
  static String projectId = dotenv.env[KApp.keyAppWriteProjectId]!;
  static String databaseId = dotenv.env[KApp.keyAppWriteDatabaseId]!;
  static String usersCollectionId =
      dotenv.env[KApp.keyAppWriteUsersCollectionId]!;
  static String eweetsCollection =
      dotenv.env[KApp.keyAppWriteEweetCollectionId]!;
  static String imagesBucket = dotenv.env[KApp.keyAppWriteImageBucket]!;
  static String imageUrl(String imageId) =>
      '$baseEndPointUrl/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
