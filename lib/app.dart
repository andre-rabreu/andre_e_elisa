import 'package:andre_e_elisa/pages/home_page.dart';
import 'package:andre_e_elisa/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "André & Elisa",
      home: const HomePage(),
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      routes: {"/home": (context) => const HomePage()},
    );
  }
}
