import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/controllers/auth_controller.dart';
import 'package:web_app/router/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next == AuthState.authenticated) {
        context.go(RouteNames.chat);
      } else if (next == AuthState.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error logging in')));
      } else if (next == AuthState.loading) {
        showDialog(
          context: context,
          builder: (context) =>
              Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
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
                  context.push(RouteNames.signup);
                },
                child: Text('New User? Signup'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(authControllerProvider.notifier)
                      .login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
