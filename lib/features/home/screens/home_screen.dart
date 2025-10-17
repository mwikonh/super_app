import 'package:flutter/material.dart';
import 'package:web_app/features/home/models/home_model.dart';
import 'package:web_app/features/home/widgets/home_menu_widget.dart';
import 'package:web_app/router/route_names.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<HomeModel> homeMenus = [
    HomeModel(
      title: 'Secure Web View',
      routeName: RouteNames.webview,
      bgColour: Color(0xFF6366F1),
      icon: Icons.web,
    ),
    HomeModel(
      title: 'Platform Channels',
      routeName: RouteNames.platformChannels,
      bgColour: Color(0xFF8B5CF6),
      icon: Icons.hardware,
    ),
    HomeModel(
      title: 'Authentication',
      routeName: RouteNames.login,
      bgColour: Color(0xFF8B5CF6),
      icon: Icons.login_outlined,
    ),
    HomeModel(
      title: 'Integrate 3rd party Web',
      routeName: RouteNames.webview,
      bgColour: Color(0xFF8B5CF6),
      icon: Icons.integration_instructions,
    ),
    HomeModel(
      title: 'Integrate 3rd party Web',
      routeName: RouteNames.webview,
      bgColour: Color(0xFF8B5CF6),
      icon: Icons.integration_instructions,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Super App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: homeMenus.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            return HomeMenuWidget(homeMenus: homeMenus[index]);
          },
        ),
      ),
    );
  }
}
