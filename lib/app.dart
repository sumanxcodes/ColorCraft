import 'package:flutter/material.dart';

class ColorCraftApp extends StatelessWidget {
  const ColorCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorCraft Kids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to ColorCraft Kids!'),
        ),
      ),
    );
  }
}
