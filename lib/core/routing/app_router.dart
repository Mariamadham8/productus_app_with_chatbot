import 'package:auth_api_app/feature/auth/presentation/ui/views/login_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Text('Home Screen'));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
