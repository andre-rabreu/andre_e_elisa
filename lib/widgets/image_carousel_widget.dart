import 'dart:convert';

import 'package:andre_e_elisa/classes/photo.dart';
import 'package:andre_e_elisa/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({super.key});

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  late Future<List<Photo>> photos;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    photos = fetchPhotos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await http.get(
        Uri.parse('https://timeline-api.andrerenato-aabreu.workers.dev'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Photo> fetchedPhotos = data
            .map((json) => Photo.fromJson(json))
            .toList();

        // --- DEBUG LOGS ---
        debugPrint("Total recebido da API: ${fetchedPhotos.length}");

        if (fetchedPhotos.isNotEmpty) {
          final removed = fetchedPhotos.removeLast();
          debugPrint(
            "Item removido: ${removed.filename}",
          ); // Veja qual foi removido
        }

        // DEBUG
        debugPrint("Total retornado para tela: ${fetchedPhotos.length}");

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
    final double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        FutureBuilder<List<Photo>>(
          future: photos,
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
                padding: EdgeInsets.only(
                  top: padding,
                  left: padding,
                  right: padding,
                  bottom: padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    // Text("Nossa Linha do Tempo", style: Theme.of(context).textTheme.titleLarge),
                    // SizedBox(height: padding),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: height / 2),
                      child: CarouselView.weighted(
                        controller: _controller,
                        itemSnapping: true,
                        flexWeights: const <int>[1, 7, 1],
                        // Mapeia sua lista de Photos para widgets visuais
                        children: photosList.map((Photo photo) {
                          return _PhotoItemCard(photo: photo);
                        }).toList(),
                      ),
                    ),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            //aqui
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PhotoItemCard extends StatelessWidget {
  final Photo photo;

  const _PhotoItemCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            photo.url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Text(
                photo.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
