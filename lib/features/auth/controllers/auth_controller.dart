import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_app/features/auth/model/users_data.dart';
import 'package:web_app/features/auth/repo/auth_repo.dart';

enum AuthState { authenticated, unauthenticated, loading, error }

class AuthController extends StateNotifier<AuthState> {
  final Ref ref;
  AuthController(this.ref) : super(AuthState.unauthenticated);

  Future signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = AuthState.loading;
    try {
      final User? user = await ref
          .read(authRepoProvider)
          .signup(name: name, email: email, password: password);
      if (user != null) {
        final UsersData usersData = UsersData(
          name: name,
          email: email,
          profilePicture: '',
          uid: user.uid,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
        await ref
            .read(authRepoProvider)
            .saveUsersDatatoDatabase(usersData: usersData);
        ref.read(userDataStateProvider.notifier).update((state) => usersData);
        state = AuthState.authenticated;
      } else {
        state = AuthState.error;
        throw Future.error(Exception('User not created'));
      }
    } catch (e) {
      state = AuthState.error;
      throw Future.error(e);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref),
);

final userDataStateProvider = StateProvider<UsersData?>((ref) => null);
