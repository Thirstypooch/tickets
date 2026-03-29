import 'package:dio/dio.dart';

/// Singleton Dio client configured for the NestJS backend.
class ApiClient {
  static Dio? _instance;

  ApiClient._();

  static Dio get instance {
    _instance ??= Dio(BaseOptions(
      // Change this to your NestJS backend URL
      baseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://localhost:3000/api',
      ),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));
    return _instance!;
  }

  /// Set auth token after login.
  static void setToken(String token) {
    instance.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear auth token on logout.
  static void clearToken() {
    instance.options.headers.remove('Authorization');
  }
}
