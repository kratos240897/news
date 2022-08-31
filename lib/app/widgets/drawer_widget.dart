import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/drawer_items.dart';
import '../data/models/drawer_item.dart';

class DrawerWidget extends StatefulWidget {
  final ValueChanged<DrawerItem> onItemSelected;
  const DrawerWidget({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  DrawerItem selectedItem = DrawerItems.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.activeBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: DrawerItems.all
                  .map((e) => InkWell(
                        onTap: () {
                          widget.onItemSelected(e);
                          setState(() {
                            selectedItem = e;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 20.0),
                          child: Row(
                            children: [
                              FaIcon(e.icon,
                                  size: 22.0,
                                  color: selectedItem == e
                                      ? Colors.white
                                      : Colors.white38),
                              const SizedBox(width: 15.0),
                              Text(e.title,
                                  style: GoogleFonts.spartan(
                                      fontWeight: selectedItem == e
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      fontSize: 16.0,
                                      color: selectedItem == e
                                          ? Colors.white
                                          : Colors.white38))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
