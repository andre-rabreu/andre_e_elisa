import 'package:andre_e_elisa/constants.dart';
import 'package:andre_e_elisa/widgets/clock_widget.dart';
import 'package:andre_e_elisa/widgets/music_player_widget.dart';
import 'package:andre_e_elisa/widgets/verse_widget.dart';
import 'package:andre_e_elisa/widgets/timeline_entry_widget.dart';
import 'package:andre_e_elisa/widgets/trivia_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> timelineEntries = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryColor, backgroundColor],
              stops: [0.0, 0.5],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  spacing: padding,
                  children: <Widget>[
                    MusicPlayerWidget(),
                    ClockWidget(),
                    VerseWidget(),
                    TriviaWidget(),
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
                    SizedBox(height: 64),
                    Text(
                      'Eu te amo!',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 128),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
