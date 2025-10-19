import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/auth/model/users_data.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<User?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        log(userCred.user!.uid);
        return userCred.user;
      } else {
        log('User not created');
        throw Exception('User not created');
      }
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      final UserCredential userCred = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        return userCred.user;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  Future<void> saveUsersDatatoDatabase({required UsersData usersData}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(usersData.uid)
          .set(usersData.toJson());
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  Future<UsersData> getUsersDataFromFirebase({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await _firebaseFirestore.collection('users').doc(uid).get();
      if (userData.exists) {
        return UsersData.fromJson(userData.data()!);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }
}

final authRepoProvider = Provider((ref) => AuthRepo());
