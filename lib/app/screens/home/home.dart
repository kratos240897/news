import 'package:flutter/material.dart';
import 'package:provider_news/app/data/drawer_items.dart';
import 'package:provider_news/app/screens/home/home_view.dart';
import 'package:provider_news/app/widgets/drawer_widget.dart';
import 'package:provider_news/app/widgets/favorites.dart';
import 'package:provider_news/app/widgets/profile.dart';
import 'package:provider_news/app/widgets/settings.dart';

import '../../models/drawer_item.dart';
import '../../widgets/explore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scaleFactor = 1.0;
  bool isDrawerOpen = false;
  bool isDragging = false;
  DrawerItem item = DrawerItems.home;
  final List<Widget> pages = [];

  @override
  void initState() {
    pages.add(HomeView(openDrawer: openDrawer));
    pages.add(Explore(openDrawer: openDrawer));
    pages.add(Favorites(openDrawer: openDrawer));
    pages.add(Profile(openDrawer: openDrawer));
    pages.add(Settings(openDrawer: openDrawer));
    super.initState();
  }

  void openDrawer() => setState(() {
        xOffset = 230.0;
        yOffset = 150.0;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      });

  void closeDrawer() => setState(() {
        xOffset = 0.0;
        yOffset = 0.0;
        scaleFactor = 1.0;
        isDrawerOpen = false;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(children: [
        SizedBox(
          width: xOffset,
          child: DrawerWidget(onItemSelected: (item) {
            setState(() {
              this.item = item;
            });
            closeDrawer();
          }),
        ),
        GestureDetector(
          onHorizontalDragStart: (details) {
            isDragging = true;
          },
          onHorizontalDragUpdate: (details) {
            if (!isDragging) return;

            const delta = 1;
            if (details.delta.dx > delta) {
              openDrawer();
            } else if (details.delta.dx < -delta) {
              closeDrawer();
            }

            isDragging = false;
          },
          onTap: () => closeDrawer(),
          child: AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 250),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              child: AbsorbPointer(
                  absorbing: isDrawerOpen,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(isDrawerOpen ? 20.0 : 0.0),
                    child: Container(
                        color: isDrawerOpen
                            ? Colors.amber.withOpacity(0.5)
                            : Colors.grey[200],
                        child: getSelectedPage()),
                  ))),
        )
      ]),
    );
  }

  Widget getSelectedPage() {
    switch (item) {
      case DrawerItems.explore:
        return pages[1];
      case DrawerItems.favorites:
        return pages[2];
      case DrawerItems.profile:
        return pages[3];
      case DrawerItems.settings:
        return pages[4];
      default:
        return pages[0];
    }
  }
}
