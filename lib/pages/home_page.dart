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
      backgroundColor: Color.fromARGB(255, 222, 153, 220),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 192),
              Text(
                'Estamos juntos há...',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              ClockWidget(),
              Image.asset(
                'assets/images/parque-flamboyant.jpg',
                width: 480,
                height: 640,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
