import 'package:flutter/material.dart';
import 'bordered_box_button.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
   final VoidCallback onTapShare;
  final IconData icon;
  const CustomAppBar(
      {Key? key,
      required this.onTapLeft,
      required this.onTapRight,
      required this.icon, required this.onTapShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BorderedBoxButton(size: 24.0, onTap: onTapLeft, icon: Icons.arrow_back),
        Row(
          children: [
            BorderedBoxButton(
                size: 24.0, onTap: onTapShare, icon: Icons.ios_share_sharp),
            const SizedBox(width: 8.0),
            BorderedBoxButton(size: 24.0, onTap: onTapRight, icon: icon)
          ],
        ),
      ],
    );
  }
}
