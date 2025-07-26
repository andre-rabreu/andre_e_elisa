import 'package:andre_e_elisa/pages/home_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Color getColor(Set<WidgetState> states) {
    //   const Set<WidgetState> interactiveStates = <WidgetState>{
    //     WidgetState.pressed,
    //     WidgetState.hovered,
    //     WidgetState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.green;
    //   }
    //   return Colors.grey;
    // }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 163, 109, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Você se chama Elisa Pimenta?",
                  style: TextStyle(color: Colors.white),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: WidgetStateColor.resolveWith(getColor),
                  fillColor: WidgetStateColor.resolveWith((states) {
                    if (isChecked) {
                      return Colors.green;
                    } else {
                      return Colors.grey;
                    }
                  }),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            FilledButton(
              onPressed: isChecked
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  : null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: Colors.grey, // Escolha a cor desejada
                disabledForegroundColor:
                    Colors.white, // Cor do texto desabilitado
              ),
              child: const Text("Acessar"),
            ),
          ],
        ),
      ),
    );
  }
}
