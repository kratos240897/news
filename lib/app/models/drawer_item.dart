import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final bool isSelected;

  const DrawerItem({this.isSelected = false, required this.title, required this.icon});
}
