import 'dart:async';

import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/features/auth/forgot_password/cubit/cubit.dart';
import 'package:job_application_tracker/router/app_navigator.dart';
import 'package:job_application_tracker/widgets/shimmer_box.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(
        GetIt.I<FirebaseAuthRepository>(),
      ),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            ),
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset email sent!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              AppNavigator.goToSignIn(context);
            },
          );
        },
        child: const _ForgotPasswordView(),
      ),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      unawaited(
        context.read<ForgotPasswordCubit>().sendPasswordResetEmail(
          _emailController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: theme.colorScheme.onPrimary),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.secondary,
              theme.colorScheme.primary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    size: 48,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Forgot Password',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to reset your password',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 48),

                // Form Card
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                            builder: (context, state) {
                              final isLoading = state.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              );

                              final buttonWidget = ElevatedButton(
                                onPressed: isLoading ? null : _submit,
                                child: const Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );

                              return isLoading
                                  ? ShimmerBox(child: buttonWidget)
                                  : buttonWidget;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
