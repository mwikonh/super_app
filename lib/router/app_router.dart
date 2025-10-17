import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/screens/login_screen.dart';
import 'package:web_app/features/auth/screens/signup_screen.dart';
import 'package:web_app/features/home/screens/home_screen.dart';
import 'package:web_app/features/platform_channels/platfrom_channels.dart';
import 'package:web_app/features/secure_web_view/common_webview.dart';
import 'package:web_app/router/route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(path: RouteNames.home, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: RouteNames.webview,
        builder: (context, state) =>
            CommonWebviewScreen(url: 'https://apple.com'),
      ),
      GoRoute(
        path: RouteNames.platformChannels,
        builder: (context, state) => PlatformChannelsScreen(),
      ),
       GoRoute(
        path: RouteNames.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => SignupScreen(),
      ),
    ],
  );
});
