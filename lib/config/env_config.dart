import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }

  // API Keys
  static String get hereApiKey => dotenv.env['HERE_API_KEY'] ?? '';
  static String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  // HERE API Credentials
  static String get hereUserId => dotenv.env['HERE_USER_ID'] ?? '';
  static String get hereClientId => dotenv.env['HERE_CLIENT_ID'] ?? '';
  static String get hereAccessKeyId => dotenv.env['HERE_ACCESS_KEY_ID'] ?? '';
  static String get hereAccessKeySecret =>
      dotenv.env['HERE_ACCESS_KEY_SECRET'] ?? '';
  static String get hereTokenEndpointUrl =>
      dotenv.env['HERE_TOKEN_ENDPOINT_URL'] ?? '';

  // Android Signing (for build scripts)
  static String get androidStorePassword =>
      dotenv.env['ANDROID_STORE_PASSWORD'] ?? '';
  static String get androidKeyPassword =>
      dotenv.env['ANDROID_KEY_PASSWORD'] ?? '';
  static String get androidKeyAlias => dotenv.env['ANDROID_KEY_ALIAS'] ?? '';
  static String get androidStoreFile => dotenv.env['ANDROID_STORE_FILE'] ?? '';
}
