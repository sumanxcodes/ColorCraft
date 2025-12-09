import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;

  const UserEntity({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.isAnonymous,
  });

  static const empty = UserEntity(id: '', isAnonymous: false);

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, isAnonymous];
}
