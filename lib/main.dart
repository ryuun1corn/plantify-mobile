import 'package:flutter/material.dart';
import 'package:plantify_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ).copyWith(secondary: Colors.indigo[400]),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
