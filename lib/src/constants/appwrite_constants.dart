import 'package:ewitter_app/src/constants/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class KAppWrite {
  // Checks if the required environment variables are available in the .env file!
  static bool checkEnvVariables() {
    List<String> envKeys = [
      KApp.keyAppWriteEndPoint,
      KApp.keyAppWriteProjectId,
      KApp.keyAppWriteDatabaseId,
      KApp.keyAppWriteUsersCollectionId,
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
}
