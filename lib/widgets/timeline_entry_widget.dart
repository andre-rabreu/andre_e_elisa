import 'package:flutter/material.dart';

class TimelineEntryWidget extends StatelessWidget {
  final String date;
  final String filename;
  final String title;

  const TimelineEntryWidget({
    super.key,
    required this.date,
    required this.filename,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 800),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Container(height: 2, color: Colors.white),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/$filename',
                width: 300,
                height: 400,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean at eleifend velit. Ut cursus nibh quis ipsum laoreet elementum. Pellentesque at sem egestas, pellentesque ligula eget, tristique diam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas vestibulum id nunc et iaculis. Sed elementum augue vitae nulla consequat, eget vehicula mi euismod. Integer nec velit in leo cursus lobortis quis non arcu. In hac habitasse platea dictumst. Duis venenatis rhoncus sapien sed ornare.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
