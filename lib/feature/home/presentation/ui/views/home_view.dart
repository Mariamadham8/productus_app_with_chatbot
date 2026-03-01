import 'package:auth_api_app/feature/auth/data/models/login_model.dart';
import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:auth_api_app/feature/auth/presentation/ui/views/login_view.dart';
import 'package:auth_api_app/feature/home/presentation/ui/widgets/drawer.dart';
import 'package:auth_api_app/feature/home/presentation/ui/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Products', style: AppFonts.font16BlackW500),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      drawer: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          print("STATE IS: $state");
          print("STATE TYPE: ${state.runtimeType}");
          final username = state is LoginSuccess
              ? state.user.firstName
              : 'error';
          final email = state is LoginSuccess ? state.user.email : 'error';

          return AppNavigationDrawer(
            username: username,
            email: email,
            onLogout: () {
              context.read<LoginCubit>().logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          );
        },
      ),
      body: const HomeScreenBody(),
    );
  }
}
