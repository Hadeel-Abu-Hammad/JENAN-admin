import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenan_admin/core/utils/validators.dart';
import 'package:jenan_admin/core/shared/app_button.dart';
import 'package:jenan_admin/core/shared/app_text_field.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/core/constants/images/image_root.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/core/constants/images/image_sizes.dart';
import 'package:jenan_admin/core/constants/routes/app_routes_consts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthLoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: red,
              ),
            );
          }

          if (state is AuthAuthenticated) {
            context.go(AppRoutesConsts.overview);
          }
        },

        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          logo,
                          width: ImageSizes.loginLogoWidth.toDouble(),
                          height: ImageSizes.loginLogoHeight.toDouble(),
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "جِنان - لوحة التحكم",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 40),

                        AppTextField(
                          controller: _emailController,
                          label: "البريد الإلكتروني",
                          hint: "admin@jenan.com",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          enabled: !isLoading,
                          validator: Validators.email,
                        ),

                        const SizedBox(height: 20),

                        AppTextField(
                          controller: _passwordController,
                          label: "كلمة المرور",
                          prefixIcon: Icons.lock,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) => _onLoginPressed(),
                          enabled: !isLoading,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                          validator: Validators.password,
                        ),

                        const SizedBox(height: 30),

                        AppButton(
                          onPressed: isLoading ? null : _onLoginPressed,
                          text: "تسجيل الدخول",
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}