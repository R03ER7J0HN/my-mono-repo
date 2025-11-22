import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/application/cubit/cubit.dart';
import 'package:job_application_tracker/features/auth/sign_in/cubit/cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(
        signInWithEmailAndPassword: GetIt.I<SignInWithEmailAndPassword>(),
      ),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (messsage) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(messsage)),
            ),
            success: () => context.read<AppCubit>().login(),
          );
        },
        builder: (context, state) {
          // return Scaffold(
          //   body: SignInForm(
          //     onValidSubmit: (email, password) =>
          //         context.cubit.signInWithEmailAndPassword(email, password),
          //   ),
          // );
          return _buildFirebaseLoginWidget();
        },
      ),
    );
  }

  fb.SignInScreen _buildFirebaseLoginWidget() {
    return fb.SignInScreen(
      actions: [
        fb.AuthStateChangeAction<fb.UserCreated>((context, state) {
          debugPrint('User created: ${state.credential}');
        }),
        fb.AuthStateChangeAction<fb.SignedIn>(
          (context, state) => context.cubit.signInSuccess(),
        ),
      ],

      providers: [
        fb.EmailAuthProvider(),
      ],

      // Title / branding
      headerBuilder: (context, constraints, _) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        );
      },

      // Optional footer
      footerBuilder: (context, action) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our Terms and Privacy Policy.',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

extension _SignInCubitX on BuildContext {
  SignInCubit get cubit => read<SignInCubit>();
}
