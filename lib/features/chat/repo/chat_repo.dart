import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/chat/model/message_model.dart';

class ChatRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String message,
    required String senderId,
  }) async {
    try {
      final MessageModel messageModel = MessageModel(
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
}

final chatRepoProvider = Provider((ref) => ChatRepo());