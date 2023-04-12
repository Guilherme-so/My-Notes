import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  const AuthUser({
    required this.isEmailVerified,
    required this.email,
  });

  final bool isEmailVerified;
  final String? email;

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email,
        isEmailVerified: user.emailVerified,
      );
}
