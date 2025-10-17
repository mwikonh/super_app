import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannelsScreen extends StatelessWidget {
  PlatformChannelsScreen({super.key});

  final methodChannel = MethodChannel('DIALOG');
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Platform Channels')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                log('Show dialog');
                if (messageController.text.isNotEmpty) {
                  showDialog(messageController.text);
                } else {
                  showDialog('Hello from Flutter');
                }
              },
              child: Text('Show dialog'),
            ),
          ],
        ),
      ),
    );
  }

  void showDialog(String msg) async {
    await methodChannel.invokeMethod('showDialog', msg);

  }
}
