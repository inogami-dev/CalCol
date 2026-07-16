import 'package:calcol/button.dart';
import 'package:calcol/calculation.dart';
import 'package:calcol/output_screen.dart';
import 'package:flutter/material.dart';

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({super.key});

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  final CalculatorLogic _calculator = CalculatorLogic();

  void _handleButtonPress(String buttonText) {
    setState(() {
      _calculator.handleButton(buttonText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 420,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        border: Border(
          left: BorderSide(width: 8, color: Colors.white12),
          right: BorderSide(width: 8, color: Colors.white12),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child: Text(
                    "Calculator Pro",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white60,
                    ),
                  ),
                ),
                Container(
                  width: 76,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutputScreen(
            child: Text(
              _calculator.displayText,
              style: const TextStyle(color: Colors.white60, fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          Button(onPressedButton: _handleButtonPress),
        ],
      ),
    );
  }
}
