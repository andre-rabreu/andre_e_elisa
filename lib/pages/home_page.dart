import 'package:andre_e_elisa/widgets/clock_widget.dart';
import 'package:andre_e_elisa/widgets/timeline_entry_widget.dart';
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
      backgroundColor: Color.fromARGB(255, 218, 152, 206),
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
              SizedBox(height: 64),
              TimelineEntryWidget(
                date: '06/06/2025',
                filename: 'pedido-de-namoro.jpg',
                title: 'O dia do pedido',
              ),
              TimelineEntryWidget(
                date: '07/07/2025',
                filename: 'parque-flamboyant.jpg',
                title: 'Passeio no parque Flamboyant',
              ),
              SizedBox(height: 128),
            ],
          ),
        ),
      ),
    );
  }
}
