import 'package:auth_api_app/feature/auth/data/models/login_model.dart';

abstract class AuthRepo {
  Future<LoginResponse> login(String username, String password);
  Future<LoginResponse> getUserProfile();
  Future<void> logout();
}
