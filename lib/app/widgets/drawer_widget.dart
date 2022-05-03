import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/drawer_items.dart';
import '../models/drawer_item.dart';

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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: DrawerItems.all
                  .map((e) => Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width * 0.50,
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                            color: selectedItem == e
                                ? Colors.amber.withOpacity(0.5)
                                : Colors.transparent,
                            borderRadius: selectedItem == e
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0))
                                : BorderRadius.zero),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          onTap: () {
                            widget.onItemSelected(e);
                            setState(() {
                              selectedItem = e;
                            });
                          },
                          title: Text(
                            e.title,
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Colors.black),
                          ),
                          leading: Icon(
                            e.icon,
                            color: Colors.black87,
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
