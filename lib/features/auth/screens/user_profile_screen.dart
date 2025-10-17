import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/features/auth/model/users_data.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UsersData? userData = ref.watch(userDataStateProvider);
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Column(
        children: [
          Text(userData!.name.toString()),
        ],
      ),
    );
  }
}
