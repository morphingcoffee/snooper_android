import 'package:flutter/material.dart';
import 'package:snooper_android_example/screens/example_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _primarySwatch = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: _primarySwatch,
        splashColor: _primarySwatch[300],
        highlightColor: _primarySwatch[200],
        backgroundColor: _primarySwatch[200],
      ),
      home: const ExampleScreen("Snooper Sample App"),
    );
  }
}
