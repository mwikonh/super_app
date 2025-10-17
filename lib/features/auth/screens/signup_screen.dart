import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/features/auth/repo/auth_repo.dart';
import 'package:web_app/router/route_names.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next == AuthState.authenticated) {
        context.go(RouteNames.chat);
      } else if (next == AuthState.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error signing up')));
      } else if (next == AuthState.loading) {
        showDialog(
          context: context,
          builder: (context) =>
              Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Already have an account? Login'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(authControllerProvider.notifier)
                      .signUp(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
