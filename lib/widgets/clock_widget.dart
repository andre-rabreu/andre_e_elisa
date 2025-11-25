import 'dart:async';
import 'package:flutter/material.dart';
import 'package:andre_e_elisa/constants.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  Timer? _timer;

  final startDate = DateTime.parse('2025-06-06 22:36:00Z');

  int years = 0;
  int months = 0;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final start = startDate.isBefore(now) ? startDate : now;
    final end = startDate.isBefore(now) ? now : startDate;

    int totalMonths = (end.year - start.year) * 12 + (end.month - start.month);

    if (end.day < start.day) {
      totalMonths--;
    }

    final baseDate = DateTime(
      start.year,
      start.month + totalMonths,
      start.day,
      start.hour,
      start.minute,
      start.second,
    );

    final diff = end.difference(baseDate);

    setState(() {
      years = totalMonths ~/ 12;
      months = totalMonths % 12;
      days = diff.inDays;
      hours = diff.inHours % 24;
      minutes = diff.inMinutes % 60;
      seconds = diff.inSeconds % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeUnits = [
      {'value': years, 'label': 'Anos'},
      {'value': months, 'label': 'Meses'},
      {'value': days, 'label': 'Dias'},
      {'value': hours, 'label': 'Horas'},
      {'value': minutes, 'label': 'Minutos'},
      {'value': seconds, 'label': 'Segundos'},
    ];

    return Card(
      color: surfaceColor,
      elevation: cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'André e Elisa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: onSurfaceColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Juntos desde 2025',
                  style: TextStyle(fontSize: 16, color: onSurfaceColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: timeUnits.map((unit) {
                return _TimeCard(
                  value: unit['value'] as int,
                  label: unit['label'] as String,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final int value;
  final String label;

  const _TimeCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Card(
        elevation: cardElevation / 2,
        color: overlayColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
