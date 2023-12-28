import 'package:brick_breaker/select_level_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

void main() {
  runApp(const MYApp());
}

class MYApp extends StatelessWidget {
  const MYApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          bodyMedium: GoogleFonts.pressStart2p(
              textStyle: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
      home: const SelectLevelScreen(),
    );
  }
}
