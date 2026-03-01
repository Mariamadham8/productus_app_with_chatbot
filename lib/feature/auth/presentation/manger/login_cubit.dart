import 'package:auth_api_app/feature/auth/data/models/login_model.dart';
import 'package:auth_api_app/feature/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(LoginLoading());
      final loginResponse = await authRepo.login(username, password);
      emit(LoginSuccess(loginResponse));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<void> getUserProfile() async {
    try {
      final loginResponse = await authRepo.getUserProfile();
      emit(LoginSuccess(loginResponse));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await authRepo.logout();
      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
