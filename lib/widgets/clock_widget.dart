import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late final tickerProvider = createTicker((elapsed) => setState(() {}));
  final startDate = DateTime.parse('2025-06-06 22:36:00Z');

  @override
  void initState() {
    tickerProvider.start();
    super.initState();
  }

  @override
  void dispose() {
    tickerProvider.stop();
    super.dispose();
  }

  String formatDuration(DateTime start, DateTime now) {
    // Garante que start <= now
    if (now.isBefore(start)) {
      final temp = start;
      start = now;
      now = temp;
    }

    // Calcula meses completos baseados no dia 10
    int months = (now.year - start.year) * 12 + (now.month - start.month);
    DateTime lastMonthAnniversary = DateTime(
      start.year,
      start.month + months,
      start.day,
      start.hour,
      start.minute,
      start.second,
    );

    if (now.isBefore(lastMonthAnniversary)) {
      months -= 1;
      lastMonthAnniversary = DateTime(
        start.year,
        start.month + months,
        start.day,
        start.hour,
        start.minute,
        start.second,
      );
    }

    Duration difference = now.difference(lastMonthAnniversary);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return '${months}m ${days}d ${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final temp = DateTime.now();

    return Text(
      formatDuration(startDate, temp),
      style: TextStyle(color: Colors.white, fontSize: 48),
    );
  }
}
