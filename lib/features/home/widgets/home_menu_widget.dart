import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/home/models/home_model.dart';
import 'package:web_app/router/route_names.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({super.key, required this.homeMenus});

  final HomeModel homeMenus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (homeMenus.routeName == RouteNames.login) {
          if (FirebaseAuth.instance.currentUser != null) {
            context.push(RouteNames.chat);
          } else {
            context.push(homeMenus.routeName);
          }
        } else {
          context.push(homeMenus.routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: homeMenus.bgColour,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(homeMenus.icon, color: Colors.white, size: 32),
            SizedBox(height: 16),
            Text(
              homeMenus.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
