import 'package:andre_e_elisa/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class TimelineEntryWidget extends StatelessWidget {
  final String date;
  final String imageUrl;
  final String title;

  const TimelineEntryWidget({
    super.key,
    required this.date,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > breakpointMobile
          ? imageWidthWeb + marginWeb * 2
          : imageWidthMobile + paddingMobile * 2,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LikeButton(
                  size: MediaQuery.of(context).size.width > breakpointMobile
                      ? 32
                      : 24,
                ),
              ),
              Text(
                date,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width > breakpointMobile
                      ? 24
                      : 16,
                ),
              ),
            ],
          ),
          Container(height: 2, color: Colors.white),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(90, 0, 0, 0),
                  spreadRadius: 5.0,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              margin: MediaQuery.of(context).size.width > breakpointMobile
                  ? EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0)
                  : EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MediaQuery.of(context).size.width > breakpointMobile
                            ? 40
                            : 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
