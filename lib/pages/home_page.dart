import 'package:andre_e_elisa/widgets/clock_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 26, 92),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Estamos juntos há...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ClockWidget(),
          ],
        ),
      ),
    );
  }
}
