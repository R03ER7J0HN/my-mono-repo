// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  final String uid;
  final String? email;

  const UserEntity({required this.uid, this.email});
}
