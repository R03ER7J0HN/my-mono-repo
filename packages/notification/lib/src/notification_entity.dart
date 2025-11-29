import 'package:equatable/equatable.dart';

/// A representation of a push notification,
/// decoupled from any specific provider.
class NotificationEntity extends Equatable {
  /// Creates an immutable [NotificationEntity] instance.
  const NotificationEntity({this.title, this.body, this.data});

  /// The title of the notification, if available.
  final String? title;

  /// The body of the notification, if available.
  final String? body;

  /// The custom data payload sent with the notification.
  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [title, body, data];
}
