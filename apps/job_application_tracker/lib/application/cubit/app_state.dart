import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notification/firebase_notification.dart';

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
    NotificationEntity? lastNotification,
  }) = _AppState;
}
