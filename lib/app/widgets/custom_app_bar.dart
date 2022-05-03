import 'package:flutter/cupertino.dart';
import 'bordered_box_button.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final IconData icon;
  const CustomAppBar({Key? key, required this.onTapLeft, required this.onTapRight, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BorderedBoxButton(
            onTap: onTapLeft,
            icon: CupertinoIcons.back),
        BorderedBoxButton(onTap: onTapRight, icon: icon)
      ],
    );
  }
}
