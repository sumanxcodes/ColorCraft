import 'package:colorcraft_kids/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity> get authStateChanges;
  UserEntity get currentUser;
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInAnonymously();
  Future<void> signOut();
}
