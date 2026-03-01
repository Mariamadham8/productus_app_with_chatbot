import 'package:auth_api_app/core/di/dependancy_injection.dart';
import 'package:auth_api_app/core/routing/app_router.dart';
import 'package:auth_api_app/feature/auth/data/local_data_source/shared_pref.dart';
import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:auth_api_app/feature/home/presentation/manger/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  init();
   WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(LocalDateSource.tokenKey);
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getit<LoginCubit>()),
        BlocProvider(create: (_) => getit<ProductCubit>()..fetchProducts()),
      ],
      child:  MyApp(isLoggedIn: token != null),
    ),
  );
}
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          navigatorKey.currentState?.pushReplacementNamed(AppRouter.homeRoute);
        } else if (state is LoginFailure) {
          navigatorKey.currentState?.pushReplacementNamed(AppRouter.loginRoute);
        }
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: isLoggedIn ? AppRouter.homeRoute : AppRouter.loginRoute,
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      ),
    );
  }
}