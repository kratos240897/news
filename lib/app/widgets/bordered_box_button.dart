import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BorderedBoxButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double? size;
  final double? padding;
  const BorderedBoxButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.size,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(padding ?? 12.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.grey.withAlpha(50), width: 1.5),
                color: Colors.white),
            child: FaIcon(
              icon,
              size: size ?? 20.h,
              color: Colors.black,
            )));
  }
}
