import 'package:flutter/cupertino.dart';
import 'bordered_box_button.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const CustomAppBar({Key? key, required this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BorderedBoxButton(
            onTap: () {
              Navigator.pop(context);
            },
            icon: CupertinoIcons.back),
        BorderedBoxButton(onTap: onTap, icon: icon)
      ],
    );
  }
}
