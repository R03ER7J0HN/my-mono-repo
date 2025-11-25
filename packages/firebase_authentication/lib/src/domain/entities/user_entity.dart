import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({required this.uid, this.email});

  final String uid;
  final String? email;

  @override
  List<Object?> get props => [uid];
}
