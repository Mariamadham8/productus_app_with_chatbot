import 'package:auth_api_app/core/error/app_error.dart';
import 'package:auth_api_app/core/error/app_error_handler.dart';
import 'package:auth_api_app/core/networking/api_endpoints.dart';
import 'package:auth_api_app/core/networking/dio_consumer.dart';
import 'package:auth_api_app/feature/auth/data/local_data_source/shared_pref.dart';
import 'package:auth_api_app/feature/auth/data/models/login_model.dart';
import 'package:auth_api_app/feature/auth/data/repos/auth_repo.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  final LocalDateSource localDateSource;
  AuthRepoImpl({required this.apiService, required this.localDateSource});
  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await apiService.post(
        ApiEndPoints.login,
        data: {"username": username, "password": password, "expiresInMins": 30},
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      await localDateSource.saveToken(loginResponse.accessToken);
      await localDateSource.saveRefreshToken(loginResponse.refreshToken);
      return loginResponse;
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<LoginResponse> getUserProfile() async {
    try {
      final token = await localDateSource.getToken();
      if (token == null) throw AppError(message: "No token found");

      final response = await apiService.get(ApiEndPoints.userProfile);
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> logout() async {
    await localDateSource.clearToken();
  }
}
