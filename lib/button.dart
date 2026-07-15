import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key});

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
    return 
      Column(
        children: [
          // Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: const Text(
              "0",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),

          // Buttons
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    print(buttons[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: Text(
                    buttons[index],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        ],
      );
    
  }
}
