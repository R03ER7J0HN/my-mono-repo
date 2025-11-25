import 'dart:convert';

import 'package:authentication/src/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _cachedUserKey = 'CACHED_USER_KEY';

class LocalDataSource {
  const LocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<void> cacheUser(UserModel user) {
    return _secureStorage.write(
      key: _cachedUserKey,
      value: json.encode(user.toJson()),
    );
  }

  Future<void> clearCache() {
    return _secureStorage.delete(key: _cachedUserKey);
  }

  Future<UserModel?> getLastSignedInUser() async {
    final jsonString = await _secureStorage.read(key: _cachedUserKey);
    if (jsonString != null) {
      return UserModel.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );
    }
    return null;
  }
}
