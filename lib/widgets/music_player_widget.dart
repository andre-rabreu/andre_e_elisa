import 'package:andre_e_elisa/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayerWidget extends StatefulWidget {
  const MusicPlayerWidget({super.key});

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AudioPlayer player;
  late AnimationController controller;

  double volume = 0.5;

  bool isPlaying = false;
  bool hasStarted = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    AudioCache.instance = AudioCache(prefix: '');
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> startPlayback() async {
    try {
      await player.setSourceUrl(
        ('https://pub-f9783e61b5a24204aeb4b2690d873059.r2.dev/songs/mil-anos.mp3'),
      );
      await player.setVolume(volume);
      await player.resume();

      setState(() {
        hasStarted = true;
        isPlaying = true;
      });
      controller.forward();
    } catch (e) {
      debugPrint("Error starting audio: $e");
    }
  }

  void togglePlayback() {
    if (!hasStarted) {
      startPlayback();
      return;
    }

    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        player.resume();
        controller.forward();
      } else {
        player.pause();
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (MediaQuery.of(context).size.width > breakpointMobile) {
          return Card(
            elevation: 8,
            color: surfaceColor,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://pub-f9783e61b5a24204aeb4b2690d873059.r2.dev/images/jorge-e-mateus.jpg',
                      width: 144,
                      height: 144,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (
                            BuildContext context,
                            Widget child,
                            ImageChunkEvent? loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 144,
                        height: 144,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.music_note,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: padding),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mil Anos',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: onSurfaceColor,
                            ),
                          ),
                          Text(
                            'Jorge e Mateus',
                            style: TextStyle(
                              fontSize: 16,
                              color: onSurfaceColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.volume_mute,
                                size: 24,
                                color: primaryColor,
                              ),
                              Expanded(
                                child: Slider(
                                  value: volume,
                                  min: 0.0,
                                  max: 1.0,
                                  label: "${(volume * 100).round()}%",
                                  activeColor: primaryColor,
                                  thumbColor: primaryColor,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      volume = newValue;
                                    });
                                    player.setVolume(newValue);
                                  },
                                ),
                              ),
                              Icon(
                                Icons.volume_up,
                                size: 24,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.skip_previous,
                                size: 24,
                                color: primaryColor,
                              ),
                              IconButton(
                                iconSize: 24,
                                onPressed: () => togglePlayback(),
                                icon: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: AnimatedIcon(
                                    icon: AnimatedIcons.play_pause,
                                    progress: controller,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.skip_next,
                                size: 24,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Card(
            elevation: 8,
            color: surfaceColor,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://pub-f9783e61b5a24204aeb4b2690d873059.r2.dev/images/jorge-e-mateus.jpg',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        loadingBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 144,
                          height: 144,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.music_note,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: padding),
                    Text(
                      'Mil Anos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onSurfaceColor,
                      ),
                    ),
                    Text(
                      'Jorge e Mateus',
                      style: TextStyle(fontSize: 16, color: onSurfaceColor),
                    ),
                    Row(
                      children: [
                        Icon(Icons.volume_mute, size: 24, color: primaryColor),
                        Expanded(
                          child: Slider(
                            value: volume,
                            min: 0.0,
                            max: 1.0,
                            label: "${(volume * 100).round()}%",
                            activeColor: primaryColor,
                            thumbColor: primaryColor,
                            onChanged: (double newValue) {
                              setState(() {
                                volume = newValue;
                              });
                              player.setVolume(newValue);
                            },
                          ),
                        ),
                        Icon(Icons.volume_up, size: 24, color: primaryColor),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.skip_previous,
                          size: 24,
                          color: primaryColor,
                        ),
                        IconButton(
                          iconSize: 24,
                          onPressed: () => togglePlayback(),
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 1),
                            ),
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: controller,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Icon(Icons.skip_next, size: 24, color: primaryColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
