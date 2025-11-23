import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/src/notification.dart';
import 'package:firebase_notification/src/notification_service_impl.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_service_impl_test.mocks.dart';

@GenerateMocks([FirebaseMessaging])
void main() {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late NotificationServiceImpl notificationService;

  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    notificationService = NotificationServiceImpl(mockFirebaseMessaging);
  });

  tearDown(() {
    notificationService.dispose();
  });

  group('getToken', () {
    const tToken = 'test_fcm_token';

    test(
      'should return token when the call to Firebase Messaging is successful',
      () async {
        // Arrange
        when(mockFirebaseMessaging.getToken()).thenAnswer((_) async => tToken);

        // Act
        final result = await notificationService.getToken();

        // Assert
        expect(result.isSuccess, true);
        expect(result.getSuccess(), tToken);
        verify(mockFirebaseMessaging.getToken());
        verifyNoMoreInteractions(mockFirebaseMessaging);
      },
    );

    test(
      'should return a FirebaseFailure when the call is unsuccessful',
      () async {
        // Arrange
        final tException = FirebaseException(
          plugin: 'test',
          message: 'An error occurred',
        );
        when(
          mockFirebaseMessaging.getToken(),
        ).thenAnswer((_) async => throw tException);

        // Act
        final result = await notificationService.getToken();

        // Assert
        expect(result.isFailure, true);
        expect(result.getFailure(), isA<FirebaseFailure>());
        verify(mockFirebaseMessaging.getToken());
        verifyNoMoreInteractions(mockFirebaseMessaging);
      },
    );
  });

  group('requestPermission', () {
    test('should complete successfully when permission is granted', () async {
      // Arrange
      when(mockFirebaseMessaging.requestPermission()).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.disabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.disabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          sound: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.disabled,
          providesAppNotificationSettings: AppleNotificationSetting.disabled,
          timeSensitive: AppleNotificationSetting.disabled,
        ),
      );

      // Act
      final result = await notificationService.requestPermission();

      // Assert
      expect(result.isSuccess, true);
      verify(mockFirebaseMessaging.requestPermission());
      verifyNoMoreInteractions(mockFirebaseMessaging);
    });

    test('should return a FirebaseFailure when permission is denied', () async {
      // Arrange
      final tException = FirebaseException(
        plugin: 'test',
        code: 'permission-denied',
      );
      when(
        mockFirebaseMessaging.requestPermission(),
      ).thenAnswer((_) async => throw tException);

      // Act
      final result = await notificationService.requestPermission();

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      verify(mockFirebaseMessaging.requestPermission());
      verifyNoMoreInteractions(mockFirebaseMessaging);
    });
  });

  group('onMessage Stream', () {
    test(
      'should emit a mapped Notification when a RemoteMessage is received',
      () {
        // Arrange
        final onMessageController = StreamController<RemoteMessage>();
        notificationService.initialize(
          onMessageStream: onMessageController.stream,
        );

        final remoteMessage = RemoteMessage(
          notification: const RemoteNotification(title: 'Title', body: 'Body'),
          data: {'id': '123'},
        );

        const expectedNotification = Notification(
          title: 'Title',
          body: 'Body',
          data: {'id': '123'},
        );

        // Act
        onMessageController.add(remoteMessage);
        onMessageController.close();

        // Assert
        expect(notificationService.onMessage, emits(expectedNotification));
      },
    );
  });

  group('onMessageOpenedApp Stream', () {
    test(
      'should emit a mapped Notification when a message opened event is received',
      () {
        // Arrange
        final onMessageOpenedAppController = StreamController<RemoteMessage>();
        notificationService.initialize(
          onMessageOpenedAppStream: onMessageOpenedAppController.stream,
        );

        final remoteMessage = RemoteMessage(
          notification: const RemoteNotification(
            title: 'Opened App Title',
            body: 'Opened App Body',
          ),
          data: {'screen': 'details', 'id': '456'},
        );

        const expectedNotification = Notification(
          title: 'Opened App Title',
          body: 'Opened App Body',
          data: {'screen': 'details', 'id': '456'},
        );

        // Assert
        expect(
          notificationService.onMessageOpenedApp,
          emits(expectedNotification),
        );

        // Act
        onMessageOpenedAppController.add(remoteMessage);
        onMessageOpenedAppController.close();
      },
    );
  });
}
