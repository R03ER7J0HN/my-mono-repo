import 'package:authentication/src/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// Model for user data serialization.
/// Uses composition pattern - converts to [UserEntity] via [toEntity].
@JsonSerializable()
class UserModel {
  const UserModel({
    required this.uid,
    this.email,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final String uid;
  final String? email;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Converts this model to a [UserEntity].
  UserEntity toEntity() => UserEntity(
    uid: uid,
    email: email,
  );
}
