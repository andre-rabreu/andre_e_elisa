import 'package:andre_e_elisa/constants.dart';
import 'package:flutter/material.dart';

class TriviaWidget extends StatelessWidget {
  const TriviaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: surfaceColor,
      elevation: cardElevation,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          spacing: padding,
          children: [AnniverssaryWidget(), NumberOfTravels()],
        ),
      ),
    );
  }
}

class AnniverssaryWidget extends StatelessWidget {
  const AnniverssaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: overlayColor,
      elevation: cardElevation / 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 24,
              child: Icon(Icons.calendar_today_outlined, color: onPrimaryColor),
            ),
            SizedBox(width: padding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'NOSSO ANIVERSÁRIO',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '6 de Junho',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: onOverlayColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberOfTravels extends StatelessWidget {
  const NumberOfTravels({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: overlayColor,
      elevation: cardElevation / 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 24,
              child: Icon(Icons.flight_takeoff, color: onPrimaryColor),
            ),
            SizedBox(width: padding),
            Expanded(
              child: Text(
                'Dedeco já visitou Goiânia 2 vezes!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: onOverlayColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
