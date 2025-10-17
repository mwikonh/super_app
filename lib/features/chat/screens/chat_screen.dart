import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/features/chat/chat_controller.dart';
import 'package:web_app/features/chat/model/message_model.dart';
import 'package:web_app/router/route_names.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MessageModel>> chatStream = ref.watch(
      chatStreamProvider,
    );
    final chatController = ref.watch(chatControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(RouteNames.userProfile);
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          chatStream.when(
            data: (data) {
              final messages = data;
              return Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Text(message.message);
                  },
                ),
              );
            },
            error: (error, stk) {
              return Text(error.toString());
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          Spacer(),
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: messageController,

                        decoration: InputDecoration(
                          hintText: 'Message',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        final message = messageController.text;
                        if (message.isEmpty) return;
                        final senderId = ref.read(userDataStateProvider)!.uid!;
                        ref
                            .read(chatControllerProvider.notifier)
                            .sendMessage(message: message, senderId: senderId);
                        messageController.clear();
                      },
                      icon: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
