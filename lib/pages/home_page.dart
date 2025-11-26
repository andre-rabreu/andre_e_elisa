import 'package:andre_e_elisa/constants.dart';
import 'package:andre_e_elisa/widgets/clock_widget.dart';
import 'package:andre_e_elisa/widgets/music_player_widget.dart';
import 'package:andre_e_elisa/widgets/special_message_widget.dart';
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
    {
      'date': '13/04/2025',
      'imageUrl': 'https://i.imgur.com/XhcGZRM.jpeg',
      'title': 'Nosso 1º encontro',
    },
    {
      'date': '21/04/2025',
      'imageUrl': 'https://i.imgur.com/OKjMfWe.jpeg',
      'title': '1ª vez na sua casa',
    },
    {
      'date': '25/04/2025',
      'imageUrl': 'https://i.imgur.com/Dj7cXzZ.jpeg',
      'title': 'Vigília no Mackenzie',
    },
    {
      'date': '11/05/2025',
      'imageUrl': 'https://i.imgur.com/c1zMV7P.jpeg',
      'title': 'Dia das mães',
    },
    {
      'date': '15/05/2025',
      'imageUrl': 'https://i.imgur.com/LU0jXH2.jpeg',
      'title': '"Aquela" conversa',
    },
    {
      'date': '06/06/2025',
      'imageUrl': 'https://i.imgur.com/EvaeDJB.jpeg',
      'title': 'O dia do pedido',
    },
    {
      'date': '07/06/2025',
      'imageUrl': 'https://i.imgur.com/2w7QmWU.jpeg',
      'title': 'Oficialmente namorados!!',
    },
    {
      'date': '10/06/2025',
      'imageUrl': 'https://i.imgur.com/tWubBGU.jpeg',
      'title': 'Jogo da seleção',
    },
    {
      'date': '12/06/2025',
      'imageUrl': 'https://i.imgur.com/KEDxg5N.jpeg',
      'title': '1º Dia dos Namorados',
    },
    {
      'date': '05/07/2025',
      'imageUrl': 'https://i.imgur.com/7cIVUW0.jpeg',
      'title': 'Show do Jorge e Mateus',
    },
    {
      'date': '07/07/2025',
      'imageUrl': 'https://i.imgur.com/DAueP66.jpeg',
      'title': 'Passeio no parque Flamboyant',
    },
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
              stops: [0.0, 0.1],
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
