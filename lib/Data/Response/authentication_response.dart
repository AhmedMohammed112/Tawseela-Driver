import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationResponse {
  final String? message;
  final UserCredential? userCredential;

  AuthenticationResponse({
    this.message,
    this.userCredential,
  });
}