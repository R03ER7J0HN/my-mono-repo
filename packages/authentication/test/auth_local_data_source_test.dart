import 'dart:convert';

import 'package:authentication/src/data/datasources/local_data_source.dart';
import 'package:authentication/src/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_local_data_source_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late LocalDataSource dataSource;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource = LocalDataSource(mockSecureStorage);
  });

  const tUid = 'testUid';
  const tEmail = 'test@test.com';
  const tUserModel = UserModel(uid: tUid, email: tEmail);
  const tCachedUserKey = 'CACHED_USER_KEY';

  group('cacheUser', () {
    test(
      'should call FlutterSecureStorage.write with correct key and value',
      () async {
        // Arrange
        when(
          mockSecureStorage.write(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await dataSource.cacheUser(tUserModel);

        // Assert
        verify(
          mockSecureStorage.write(
            key: tCachedUserKey,
            value: json.encode(tUserModel.toJson()),
          ),
        );
      },
    );
  });

  group('getLastSignedInUser', () {
    test('should return UserModel when there is one in the cache', () async {
      // Arrange
      when(
        mockSecureStorage.read(key: tCachedUserKey),
      ).thenAnswer((_) async => json.encode(tUserModel.toJson()));

      // Act
      final result = await dataSource.getLastSignedInUser();

      // Assert
      verify(mockSecureStorage.read(key: tCachedUserKey));
      expect(result, equals(tUserModel));
    });

    test('should return null when there is no user in the cache', () async {
      // Arrange
      when(
        mockSecureStorage.read(key: tCachedUserKey),
      ).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getLastSignedInUser();

      // Assert
      verify(mockSecureStorage.read(key: tCachedUserKey));
      expect(result, isNull);
    });
  });

  group('clearCache', () {
    test('should call FlutterSecureStorage.delete with correct key', () async {
      // Arrange
      when(
        mockSecureStorage.delete(key: anyNamed('key')),
      ).thenAnswer((_) async {});

      // Act
      await dataSource.clearCache();

      // Assert
      verify(mockSecureStorage.delete(key: tCachedUserKey));
    });
  });
}
