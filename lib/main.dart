import 'package:e_commerce_app/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
