import 'package:firebase_notification/firebase_notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

enum AppStatus {
  initial,
  authenticated,
  unauthenticated,
}

@freezed
sealed class AppState with _$AppState {
  const factory AppState({
    required AppStatus status,
    Notification? lastNotification,
  }) = _AppState;
}
