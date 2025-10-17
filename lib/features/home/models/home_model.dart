import 'package:flutter/material.dart';

class HomeModel {
  final String title;
  final String routeName;
  final Color bgColour;
  final IconData icon;

  HomeModel({
    required this.title,
    required this.routeName,
    required this.bgColour,
    required this.icon,
  });
}
