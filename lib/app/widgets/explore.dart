import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';

class Explore extends StatelessWidget {
  final VoidCallback openDrawer;
  const Explore({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              CustomAppBar(
                  onTapLeft: openDrawer,
                  onTapRight: () {},
                  icon: FontAwesomeIcons.heart),
              Expanded(
                  child: Center(
                child: Text(
                  'Explore',
                  style: GoogleFonts.nunito(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
