import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/application/cubit/app_state.dart';

class AppCubit extends Cubit<AppState>
    with ChangeNotifier, SafeEmitMixin<AppState> {
  AppCubit() : super(const AppState(status: AppStatus.initial)) {
    unawaited(checkAuthStatus());
  }

  void login() => safeEmit(const AppState(status: AppStatus.loggedIn));

  void logout() => safeEmit(const AppState(status: AppStatus.loggedOut));

  Future<void> checkAuthStatus() async {
    // Simulate some delay for checking auth status
    Future.delayed(const Duration(seconds: 2), () {
      safeEmit(const AppState(status: AppStatus.loggedOut));
    });
  }

  @override
  void emit(AppState state) {
    super.emit(state);
    notifyListeners();
  }
}
