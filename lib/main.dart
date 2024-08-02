import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CalculatorHomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/logo1.jpg'), // Updated asset path
      ),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = '';
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  bool shouldResetDisplay = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '';
        num1 = 0;
        num2 = 0;
        operation = '';
      } else if (buttonText == 'CE') {
        display = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        if (display.isNotEmpty) {
          num1 = double.parse(display);
          operation = buttonText;
          display = '';
        }
      } else if (buttonText == '=') {
        if (display.isNotEmpty && operation.isNotEmpty) {
          num2 = double.parse(display);
          switch (operation) {
            case '+':
              display = (num1 + num2).toString();
              break;
            case '-':
              display = (num1 - num2).toString();
              break;
            case '*':
              display = (num1 * num2).toString();
              break;
            case '/':
              display = num2 != 0 ? (num1 / num2).toString() : 'ERROR';
              break;
          }
          num1 = 0;
          num2 = 0;
          operation = '';
        }
      } else {
        if (shouldResetDisplay) {
          display = buttonText;
          shouldResetDisplay = false;
        } else {
          display += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor, {bool isCircular = true}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: isCircular
                ? CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            color: Colors.grey[900],
            child: Text(
              display,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.white),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton('1', Colors.white, Colors.black),
                  buildButton('2', Colors.white, Colors.black),
                  buildButton('3', Colors.white, Colors.black),
                  buildButton('+', Color.fromARGB(255, 225, 118, 18), Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.white, Colors.black),
                  buildButton('5', Colors.white, Colors.black),
                  buildButton('6', Colors.white, Colors.black),
                  buildButton('-', Color.fromARGB(255, 225, 118, 18), Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('7', Colors.white, Colors.black),
                  buildButton('8', Colors.white, Colors.black),
                  buildButton('9', Colors.white, Colors.black),
                  buildButton('*', Color.fromARGB(255, 225, 118, 18), Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('CE', Colors.grey.shade600, Colors.black),
                  buildButton('0', Colors.white, Colors.black),
                  buildButton('.', Colors.white, Colors.black),
                  buildButton('/', Color.fromARGB(255, 225, 118, 18), Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('=', Color.fromARGB(255, 225, 118, 18), Colors.white, isCircular: false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
