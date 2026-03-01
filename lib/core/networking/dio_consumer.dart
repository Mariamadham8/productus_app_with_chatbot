import 'package:auth_api_app/core/networking/api_endpoints.dart';
import 'package:auth_api_app/core/routing/app_router.dart';
import 'package:auth_api_app/feature/auth/data/local_data_source/shared_pref.dart';
import 'package:auth_api_app/main.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndPoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {"Content-Type": "application/json"},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(LocalDateSource.tokenKey);

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print("Request: ${options.method} ${options.uri}");
          print("Token: $token");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final prefs = await SharedPreferences.getInstance();
            final refreshToken = prefs.getString(
              LocalDateSource.refreshTokenKey,
            );

            if (refreshToken != null) {
              try {
                final response = await Dio().post(
                  ApiEndPoints.baseUrl + ApiEndPoints.refresh,
                  data: {'refreshToken': refreshToken, 'expiresInMins': 30},
                );

                final newAccessToken = response.data['accessToken'];
                await prefs.setString(LocalDateSource.tokenKey, newAccessToken);

                e.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                final retryResponse = await _dio.fetch(e.requestOptions);
                return handler.resolve(retryResponse);
              } catch (_) {
                await prefs.clear();
                navigatorKey.currentState?.pushReplacementNamed(
                  AppRouter.loginRoute,
                );
              }
            } else {
              await prefs.clear();
              navigatorKey.currentState?.pushReplacementNamed(
                AppRouter.loginRoute,
              );
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return "Error: ${e.response?.statusCode} - ${e.response?.data}";
    } else {
      return "Network error: ${e.message}";
    }
  }
}
