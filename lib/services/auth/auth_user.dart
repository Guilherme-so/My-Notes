import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  const AuthUser({
    required this.id,
    required this.isEmailVerified,
    required this.email,
  });

  final String id;
  final String email;
  final bool isEmailVerified;

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
}
