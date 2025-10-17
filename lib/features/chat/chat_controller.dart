import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/chat/model/message_model.dart';
import 'package:web_app/features/chat/repo/chat_repo.dart';

enum ChatState { initial, loading, sending, sent, error }

class ChatController extends StateNotifier<ChatState> {
  final Ref ref;
  ChatController(this.ref) : super(ChatState.initial);

  Future sendMessage({
    required String message,
    required String senderId,
  }) async {
    state = ChatState.sending;
    try {
      await ref
          .read(chatRepoProvider)
          .sendMessage(message: message, senderId: senderId);
      state = ChatState.sent;
    } catch (e) {
      state = ChatState.error;
      throw Exception(e);
    }
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>(
  (ref) => ChatController(ref),
);

final chatStreamProvider = StreamProvider<List<MessageModel>>((ref) {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  return _firebaseFirestore
      .collection('messages')
      .orderBy('createdAt', descending: false)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((doc) => MessageModel.fromJson(doc.data())).toList(),
      );
});
