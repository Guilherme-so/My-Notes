import 'package:mynotes/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;
  Future<AuthUser> login({
    required email,
    required password,
  });
  Future<AuthUser> createUser({
    required email,
    required password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
}
