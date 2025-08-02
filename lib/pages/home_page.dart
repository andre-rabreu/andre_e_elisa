import 'package:andre_e_elisa/widgets/clock_widget.dart';
import 'package:andre_e_elisa/widgets/timeline_entry_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> timelineEntries = [
    {
      'date': '06/06/2025',
      'imageUrl': 'https://i.imgur.com/EvaeDJB.jpeg',
      'title': 'O dia do pedido',
    },
    {
      'date': '07/07/2025',
      'imageUrl': 'https://i.imgur.com/Iik2Hxf.jpeg',
      'title': 'Passeio no parque Flamboyant',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 152, 206),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 192),
                Text(
                  'Estamos juntos há...',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClockWidget(),
                ),
                Column(
                  children: timelineEntries
                      .expand(
                        (entry) => [
                          SizedBox(height: 64),
                          TimelineEntryWidget(
                            date: entry['date']!,
                            imageUrl: entry['imageUrl']!,
                            title: entry['title']!,
                          ),
                        ],
                      )
                      .toList(),
                ),
                SizedBox(height: 128),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
