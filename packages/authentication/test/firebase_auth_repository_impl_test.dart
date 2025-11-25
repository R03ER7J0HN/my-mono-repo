import 'package:authentication/firebase_authentication.dart';
import 'package:authentication/src/data/datasources/local_data_source.dart';
import 'package:authentication/src/data/models/user_model.dart';
import 'package:authentication/src/data/repositories/firebase_auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_repository_impl_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User, LocalDataSource])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockLocalDataSource mockLocalDataSource;
  late FirebaseAuthRepositoryImpl repository;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tUid = 'testUid';

  const tUserEntity = UserEntity(uid: tUid, email: tEmail);
  const tUserModel = UserModel(uid: tUid, email: tEmail);
  final tFirebaseAuthException = FirebaseAuthException(
    code: 'test-error',
    message: 'An error occurred',
  );

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockLocalDataSource = MockLocalDataSource();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    repository = FirebaseAuthRepositoryImpl(
      mockFirebaseAuth,
      mockLocalDataSource,
    );
  });

  // -----------------------------
  // Helpers
  // -----------------------------

  void stubUser() {
    when(mockUser.uid).thenReturn(tUid);
    when(mockUser.email).thenReturn(tEmail);
  }

  void stubCredentialWithUser() {
    when(mockUserCredential.user).thenReturn(mockUser);
  }

  void stubCredentialWithNullUser() {
    when(mockUserCredential.user).thenReturn(null);
  }

  group('signUpWithEmailAndPassword', () {
    test('returns UserEntity on successful signup', () async {
      // Arrange
      stubUser();
      stubCredentialWithUser();

      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), equals(tUserEntity));

      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      );
      verify(mockLocalDataSource.cacheUser(tUserModel));
      verifyNoMoreInteractions(mockFirebaseAuth);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('returns FirebaseFailure when returned user is null', () async {
      // Arrange
      stubCredentialWithNullUser();

      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());

      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyZeroInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('returns FirebaseFailure on FirebaseAuthException', () async {
      // Arrange
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => throw tFirebaseAuthException);

      // Act
      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      expect(
        result.getFailure().message,
        equals(tFirebaseAuthException.message),
      );

      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('signInWithEmailAndPassword', () {
    test('returns UserEntity on successful sign in', () async {
      // Arrange
      stubUser();
      stubCredentialWithUser();

      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), equals(tUserEntity));
      verify(mockLocalDataSource.cacheUser(tUserModel));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('returns FirebaseFailure when user is null after sign in', () async {
      // Arrange
      stubCredentialWithNullUser();

      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<Failure>());

      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('returns FirebaseFailure on FirebaseAuthException', () async {
      // Arrange
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => throw tFirebaseAuthException);

      // Act
      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      expect(
        result.getFailure().message,
        equals(tFirebaseAuthException.message),
      );
    });
  });

  group('getSignedInUser', () {
    test('returns UserEntity when user is signed in', () async {
      // Arrange
      stubUser();
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      // Act
      final result = await repository.getSignedInUser();

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), equals(tUserEntity));
      verify(mockLocalDataSource.cacheUser(tUserModel));
    });

    test('returns null when no user is signed in', () async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);

      // Act
      final result = await repository.getSignedInUser();

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), isNull);
      verify(mockLocalDataSource.clearCache());
    });

    test('returns cached user when FirebaseAuth throws exception', () async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => throw Exception());
      when(
        mockLocalDataSource.getLastSignedInUser(),
      ).thenAnswer((_) async => tUserModel);

      // Act
      final result = await repository.getSignedInUser();

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), equals(tUserModel));
      verify(mockLocalDataSource.getLastSignedInUser());
    });

    test(
      'returns failure when FirebaseAuth throws exception and no cached user',
      () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenThrow(Exception('Error'));
        when(
          mockLocalDataSource.getLastSignedInUser(),
        ).thenAnswer((_) async => null);

        // Act
        try {
          await repository.getSignedInUser();
        } on Exception catch (e) {
          // Assert
          expect(e, isA<FirebaseFailure>());
        }
        verify(mockLocalDataSource.getLastSignedInUser());
      },
    );
  });

  group('logOut', () {
    test('returns success when logout completes', () async {
      // Arrange
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

      // Act
      final result = await repository.logOut();

      // Assert
      expect(result.isSuccess, true);
      verify(mockFirebaseAuth.signOut());
      verify(mockLocalDataSource.clearCache());
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('returns FirebaseFailure on FirebaseAuthException', () async {
      // Arrange
      when(
        mockFirebaseAuth.signOut(),
      ).thenAnswer((_) async => throw tFirebaseAuthException);

      // Act
      final result = await repository.logOut();

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      expect(
        result.getFailure().message,
        equals(tFirebaseAuthException.message),
      );
    });
  });

  group('deleteAccount', () {
    test('returns success when account deletion completes', () async {
      // Arrange
      stubUser();
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.delete()).thenAnswer((_) async => {});

      // Act
      final result = await repository.deleteAccount();

      // Assert
      expect(result.isSuccess, true);
      verify(mockUser.delete());
      verify(mockLocalDataSource.clearCache());
    });

    test('returns FirebaseFailure when no user logged in', () async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);

      // Act
      final result = await repository.deleteAccount();

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      expect(
        result.getFailure().message,
        equals(FirebaseFailure.notLoggedIn().message),
      );
    });

    test('returns FirebaseFailure on FirebaseAuthException', () async {
      // Arrange
      stubUser();
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(
        mockUser.delete(),
      ).thenAnswer((_) async => throw tFirebaseAuthException);

      // Act
      final result = await repository.deleteAccount();

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<FirebaseFailure>());
      expect(
        result.getFailure().message,
        equals(tFirebaseAuthException.message),
      );
    });
  });
}
