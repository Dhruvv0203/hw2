import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalculatorApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  CalculatorHomeState createState() => CalculatorHomeState();
}

class CalculatorHomeState extends State<CalculatorHome> {
  String displayText = "";
  double? firstOperand;
  String? operator;
  bool shouldResetDisplay = false;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
    setState(() {
        displayText = "0";  // Set display to "0" after clearing
        firstOperand = null;
        operator = null;
    });
  } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (displayText.isNotEmpty) {
          firstOperand = double.tryParse(displayText);
          operator = value;
          shouldResetDisplay = true;
        }
      } else if (value == '=') {
        if (firstOperand != null && operator != null && displayText.isNotEmpty) {
          double secondOperand = double.tryParse(displayText) ?? 0;
          double result = 0;

          if (operator == '+') {
            result = firstOperand! + secondOperand;
          } else if (operator == '-') {
            result = firstOperand! - secondOperand;
          } else if (operator == '*') {
            result = firstOperand! * secondOperand;
          } else if (operator == '/') {
            result = secondOperand == 0 ? double.nan : firstOperand! / secondOperand;
          }

          displayText = result.toString();
          firstOperand = null;
          operator = null;
        }
      } else {
        if (shouldResetDisplay) {
          displayText = value;
          shouldResetDisplay = false;
        } else {
          displayText += value;
        }
      }
    });
  }

  Widget buildButton(String value, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: MaterialButton(
          color: color,
          padding: const EdgeInsets.all(24.0),
          onPressed: () => buttonPressed(value),
          child: Text(
            value,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CalculatorApp'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24.0),
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("C", color: Colors.red),
                  buildButton("=", color: Colors.green),
                  buildButton("+", color: Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
