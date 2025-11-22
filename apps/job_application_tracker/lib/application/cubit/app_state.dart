import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

enum AppStatus {
  initial,
  loggedIn,
  loggedOut,
}

@freezed
sealed class AppState with _$AppState {
  const factory AppState({required AppStatus status}) = _AppState;
}
