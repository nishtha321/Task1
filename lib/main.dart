import 'package:flutter/material.dart';
import 'package:task1/screens/user_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profiles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserGrid(),
    );
  }
}
