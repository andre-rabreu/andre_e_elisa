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

  bool isPlaying = true;

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
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await player.setSource(AssetSource('songs/mil-anos.mp3'));
      await player.setVolume(volume);
      await player.resume();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  void togglePlay() => setState(() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      controller.reverse();
      player.resume();
    } else {
      controller.forward();
      player.pause();
    }
  });

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                8,
              ),
              child: Image.asset(
                'images/jorge-e-mateus.jpg',
                width: 128, // Tamanho fixo
                height: 128,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 128,
                  height: 128,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.music_note,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(width: 24,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 24,
                        onPressed: () => togglePlay(),
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          progress: controller,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.volume_mute, size: 20),
                      Expanded(
                        child: Slider(
                          value: volume,
                          min: 0.0,
                          max: 1.0,
                          label: "${(volume * 100).round()}%",
                          onChanged: (double newValue) {
                            setState(() {
                              volume = newValue;
                            });
                            player.setVolume(newValue);
                          },
                        ),
                      ),
                      const Icon(Icons.volume_up, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
