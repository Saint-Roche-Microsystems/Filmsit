import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get apiPosterUrl => dotenv.env['API_POSTER_URL'] ?? '';
  static String get apiToken => dotenv.env['API_TOKEN'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }

  static bool validate() {
    return apiBaseUrl.isNotEmpty && apiToken.isNotEmpty && apiPosterUrl.isNotEmpty;
  }
}