import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/router/route_names.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
