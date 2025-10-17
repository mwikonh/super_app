import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        log(userCred.user!.uid);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

final authRepoProvider = Provider((ref) => AuthRepo());
