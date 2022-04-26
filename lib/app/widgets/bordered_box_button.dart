import 'package:flutter/material.dart';

class BorderedBoxButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const BorderedBoxButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 4.0,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withAlpha(5), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: Icon(
                icon,
                size: 28.0,
              ));
        }),
      ),
    );
  }
}