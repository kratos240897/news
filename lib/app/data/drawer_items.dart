import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/drawer_item.dart';

class DrawerItems {
  static const home = DrawerItem(
      title: 'Home', icon: FontAwesomeIcons.rocket, isSelected: true);
  static const explore = DrawerItem(title: 'Explore', icon: Icons.explore);
  static const favorites = DrawerItem(title: 'Favorites', icon: Icons.favorite);
  static const profile =
      DrawerItem(title: 'Profile', icon: FontAwesomeIcons.locationDot);
  static const settings = DrawerItem(title: 'Settings', icon: Icons.settings);

  static final List<DrawerItem> all = [
    home,
    explore,
    favorites,
    profile,
    settings,
  ];
}
