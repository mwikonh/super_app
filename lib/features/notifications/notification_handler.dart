import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/router/route_names.dart';

class NotificationHandlerRepo {
  void askNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  Future<String> getFCMtoken() async {
    String? token;
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.getAPNSToken();
      token = await FirebaseMessaging.instance.getToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }
    return token ?? '';
  }

  Future<void> saveFCMtokenToDatabase({required String token}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'fcmToken': token});
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
    // Save FCM token to Firebase.
  }

  void firebaseMessageHandler(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //Query message data from firebase Remote Message.
      // Navigate to X dcereen
      if (message.data['type'] == 'chat') {
        context.go(RouteNames.chat);
      }
    });
  }
}

final notificationHandlerRepoProvider = Provider(
  (ref) => NotificationHandlerRepo(),
);
