import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCase extends StatelessWidget {
  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final bool isCircleBorder;
  const CustomShowCase(
      {Key? key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      required this.isCircleBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      shapeBorder: isCircleBorder
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      contentPadding: const EdgeInsets.all(15.0),
      titleTextStyle:
          GoogleFonts.spartan(fontWeight: FontWeight.w600, fontSize: 20.0),
      descTextStyle: GoogleFonts.quicksand(
          letterSpacing: 1.2,
          fontSize: 18.0,
          color: Colors.black87,
          fontWeight: FontWeight.w400),
      child: child,
    );
  }
}