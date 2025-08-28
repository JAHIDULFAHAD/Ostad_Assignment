import 'package:flutter/material.dart';

import 'Screen/home_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud Api',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
