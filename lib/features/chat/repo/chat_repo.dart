import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/features/chat/model/message_model.dart';

class ChatRepo {
  final Ref ref;
  ChatRepo(this.ref);
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String message,
    required String senderId,
  }) async {
    try {
      final MessageModel messageModel = MessageModel(
        senderName: ref.read(userDataStateProvider)!.name,
        message: message,
        senderId: senderId,
        messageType: 'text',
        createdAt: DateTime.now().toIso8601String(),
        messageUrl: '',
      );

      await _firebaseFirestore
          .collection('messages')
          .add(messageModel.toJson());
      log(messageModel.toJson().toString());
    } on Exception catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  bool isSentByCurrentUser({required String messageSenderId}) {
    return messageSenderId == FirebaseAuth.instance.currentUser?.uid;
  }
}

final chatRepoProvider = Provider((ref) => ChatRepo(ref));
