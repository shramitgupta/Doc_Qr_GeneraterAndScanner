import 'package:flutter/material.dart';
import 'package:scanweb/option.dart';
import 'package:scanweb/scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Option(),
    );
  }
}
