import 'package:andre_e_elisa/constants.dart';
import 'package:flutter/material.dart';

class VerseWidget extends StatefulWidget {
  const VerseWidget({super.key});

  @override
  State<VerseWidget> createState() => VerseWidgetState();
}

class VerseWidgetState extends State<VerseWidget> {
  bool isExpanded = false;

  Widget _buildMessageContent(String text) {
    TextStyle textStyle = TextStyle(
      fontSize: 24,
      color: onSurfaceColor,
      fontWeight: FontWeight.w900,
      height: 1.5,
    );

    if (isExpanded) {
      return Column(
        children: [
          Text(text, style: textStyle),
          SizedBox(height: 8.0),
        ],
      );
    } else {
      return Container(
        height: 96,
        alignment: Alignment.topCenter,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.white, Colors.transparent],
              stops: [0.6, 1.0],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Text(text, style: textStyle),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const String verse =
        '"Àquele que é capaz de fazer infinitamente mais do que tudo o que pedimos ou pensamos, segundo o seu poder que atua em nós, a ele seja a glória na igreja em Cristo Jesus, por todas as gerações, pelos séculos dos séculos! Amém!"';

    return Card(
      elevation: cardElevation,
      color: surfaceColor,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: padding,
          children: [
            Text(
              'Efésios 3:20-21',
              style: TextStyle(
                fontSize: 16,
                color: onSurfaceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _buildMessageContent(verse),
            ),
            FilledButton(
              onPressed: () => setState(() {
                isExpanded = !isExpanded;
              }),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: onPrimaryColor,
                elevation: 0,
              ),
              child: Text(
                !isExpanded ? 'Mostrar versículo' : 'Ocultar versículo',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
