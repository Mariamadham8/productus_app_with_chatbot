import 'package:auth_api_app/feature/home/presentation/ui/widgets/drawer.dart';
import 'package:auth_api_app/feature/home/presentation/ui/widgets/home_body.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
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
      drawer: AppNavigationDrawer(
        username: 'Alex Morgan',
        email: 'alex.morgan@example.com',
        onLogout: () {
          // TODO: call AuthCubit logout
        },
      ),
      body: const HomeScreenBody(products: [], isLoading: false),
    );
  }
}
