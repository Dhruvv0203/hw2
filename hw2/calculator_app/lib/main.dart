import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Calculator',
      theme: ThemeData.dark(),  // Dark theme like iOS Calculator
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
  String expression = "";  // Stores full equation (e.g., 2+3=)
  String result = "0";  // Stores the result

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        expression = "";
        result = "0";
      } else if (value == '=') {
        try {
          result = evaluateExpression(expression).toString();
          expression += " =";  // Show the full equation before resetting
        } catch (e) {
          result = "Error";
        }
      } else {
        if (expression.endsWith("=")) {
          expression = "";  // Reset if a new calculation starts
        }
        expression += value;
      }
    });
  }

  double evaluateExpression(String exp) {
    try {
      return double.parse(
        exp.replaceAll('×', '*').replaceAll('÷', '/')
      ); // Simple parsing for now
    } catch (e) {
      return double.nan;
    }
  }

  Widget buildButton(String value, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => buttonPressed(value),
          child: Text(value, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(expression, style: const TextStyle(fontSize: 32, color: Colors.white54)),
                  Text(result, style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [buildButton("AC", color: Colors.grey), buildButton("+/-", color: Colors.grey), buildButton("%", color: Colors.grey), buildButton("÷", color: Colors.orange)]),
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("×", color: Colors.orange)]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("-", color: Colors.orange)]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("+", color: Colors.orange)]),
              Row(children: [buildButton("0"), buildButton(".", color: Colors.grey), buildButton("C", color: Colors.red), buildButton("=", color: Colors.orange)]),
            ],
          ),
        ],
      ),
    );
  }
}
