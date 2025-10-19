import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/features/auth/model/users_data.dart';
import 'package:web_app/features/auth/repo/auth_repo.dart';
import 'package:web_app/router/route_names.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UsersData? userData = ref.watch(userDataStateProvider);
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
              // backgroundImage: NetworkImage(userData!.profilePicture),
            ),
            Text(userData!.name.toString()),
            ElevatedButton(
              onPressed: () {
                ref.read(authRepoProvider).signOut().then((value) {
                  if (context.mounted) {
                    context.go('/');
                  }
                });
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
