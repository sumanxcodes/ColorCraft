import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  UserEntity _currentUser = UserEntity.empty;

  @override
  Stream<UserEntity> get authStateChanges => Stream.value(_currentUser);

  @override
  UserEntity get currentUser => _currentUser;

  @override
  Future<void> signInAnonymously() async {
    _currentUser = const UserEntity(
      id: 'mock_guest_id',
      email: '',
      displayName: 'Guest User',
      photoUrl: '',
      isAnonymous: true,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    _currentUser = const UserEntity(
      id: 'mock_google_id',
      email: 'test@example.com',
      displayName: 'Mock Google User',
      photoUrl: '',
      isAnonymous: false,
    );
  }

  @override
  Future<void> signInWithApple() async {
    _currentUser = const UserEntity(
      id: 'mock_apple_id',
      email: 'test@apple.com',
      displayName: 'Mock Apple User',
      photoUrl: '',
      isAnonymous: false,
    );
  }

  @override
  Future<void> signOut() async {
    _currentUser = UserEntity.empty;
  }
}
