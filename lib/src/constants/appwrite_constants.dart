import 'package:flutter_dotenv/flutter_dotenv.dart';

class KAppWrite {
  // Checks if the required environment variables are available in the .env file!
  static bool checkEnvVariables() {
    List<String> envKeys = [
      "APP_WRITE_END_POINT",
      "APP_WRITE_PROJECT_ID",
      "APP_WRITE_DATABASE_ID"
    ];

    for (int i = 0; i < envKeys.length; i++) {
      if (dotenv.env[envKeys[i]] == null) {
        return false;
      }
    }

    return true;
  }

  static const String projectId = "6439bcdd4a97e9e4f785";
  static const String databaseId = "6439be5d13e3905d2cae";
  static String baseEndPointUrl =
      dotenv.env["APP_WRITE_END_POINT"] ?? "APP WRITE NOT FOUND!";
  // static const String baseEndPointUrl = "http://localhost/80/v1";
}
