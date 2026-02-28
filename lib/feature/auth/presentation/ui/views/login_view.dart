import 'package:auth_api_app/core/helpers/validators.dart';
import 'package:auth_api_app/core/widgets/custom_button.dart';
import 'package:auth_api_app/core/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/app_color.dart';
import '../../../../../core/theming/app_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 36,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text('Welcome Back', style: AppFonts.font24BlackW700),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    'Login to your assistant to continue',
                    style: AppFonts.font14GreyW400,
                  ),
                ),

                const SizedBox(height: 40),

                Text('Username', style: AppFonts.font14BlackW500),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Username or Email',
                  controller: _usernameController,
                  prefixIcon: Icons.person_outline,
                  validator: AppValidators.validateUsername,
                ),

                const SizedBox(height: 20),

                Text('Password', style: AppFonts.font14BlackW500),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hintText: 'Password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: AppValidators.validatePassword,
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: AppFonts.font14PrimaryW500,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                CustomButton(text: 'Log In', onPressed: _onLoginPressed),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
