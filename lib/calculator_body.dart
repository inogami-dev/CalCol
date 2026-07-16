import 'package:calcol/button.dart';
import 'package:calcol/output_screen.dart';
import 'package:flutter/material.dart';

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({super.key});

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 550,
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
        children: [
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
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
          SizedBox(height: 16),
          OutputScreen(
            child: Text("Result", style: TextStyle(color: Colors.white60)),
          ),
        ],
      ),
    );
  }
}
