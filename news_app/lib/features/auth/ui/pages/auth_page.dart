import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/domain/cubit/auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  void auth(BuildContext blocContext) {
    if (_formKey.currentState!.validate()) {
      blocContext.read<AuthCubit>().auth(
        _loginController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.router.replacePath('/home');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'NEWS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1F1F1F),
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 56),
                        const Text(
                          'С возвращением',
                          style: TextStyle(
                            color: Color(0xFF1F1F1F),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Войдите, чтобы читать последние новости.',
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _AuthTextField(
                          controller: _loginController,
                          label: 'Логин',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Введите логин'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        _AuthTextField(
                          controller: _passwordController,
                          label: 'Пароль',
                          obscureText: _isPasswordHidden,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Введите пароль'
                              : null,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _isPasswordHidden = !_isPasswordHidden,
                            ),
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return SizedBox(
                              height: 58,
                              child: FilledButton(
                                onPressed: isLoading
                                    ? null
                                    : () => auth(context),
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF1F1F1F),
                                  disabledBackgroundColor: const Color(
                                    0xFF1F1F1F,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'ВОЙТИ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF3F1F0),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF1F1F1F), width: 1.5),
        ),
      ),
    );
  }
}
