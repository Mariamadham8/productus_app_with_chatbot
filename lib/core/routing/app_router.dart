import 'package:auth_api_app/core/di/dependancy_injection.dart';
import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:auth_api_app/feature/auth/presentation/ui/views/login_view.dart';
import 'package:auth_api_app/feature/home/presentation/manger/product_cubit.dart';
import 'package:auth_api_app/feature/home/presentation/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
