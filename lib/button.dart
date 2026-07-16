import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function(String) onPressedButton;

  const Button({super.key, required this.onPressedButton});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final List<String> buttons = [
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "*",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    "=",
    "+",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: buttons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final buttonText = buttons[index];
          final buttonWidget = ElevatedButton(
            onPressed: () {
              widget.onPressedButton(buttonText);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
            ),
            child: Text(buttonText, style: const TextStyle(fontSize: 20)),
          );

          if (buttonText == 'C') {
            return GestureDetector(
              onLongPress: () {
                widget.onPressedButton('AC');
              },
              child: buttonWidget,
            );
          }

          return buttonWidget;
        },
      ),
    );
  }
}
