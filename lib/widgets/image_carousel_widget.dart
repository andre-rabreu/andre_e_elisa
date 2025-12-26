import 'dart:convert';

import 'package:andre_e_elisa/classes/photo.dart';
import 'package:andre_e_elisa/constants.dart';
import 'package:andre_e_elisa/widgets/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({super.key});

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  late Future<List<Photo>> futurePhotosList;
  final CarouselController _controller = CarouselController();

  double previousPosition = 0;

  @override
  void initState() {
    super.initState();
    futurePhotosList = fetchPhotos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await http.get(
        Uri.parse('https://timeline-api-production.andrerenato-aabreu.workers.dev'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Photo> fetchedPhotos = data
            .map((json) => Photo.fromJson(json))
            .toList();

        return fetchedPhotos;
      } else {
        print("Erro do servidor: ${response.statusCode}");
        throw Exception(
          'Failed when loading photos. Status: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      print("Error: $e \n$stackTrace");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: futurePhotosList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No photos found."));
        }

        final photosList = snapshot.data!;

        return Card(
          color: surfaceColor,
          elevation: cardElevation,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width > breakpointMobile
                    ? 512
                    : 320,
              ),
              child: CarouselView.weighted(
                controller: _controller,
                itemSnapping: true,
                enableSplash: false,
                flexWeights: const <int>[1, 7, 1],
                children: photosList.map((Photo photo) {
                  return PhotoWidget(photo: photo);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
