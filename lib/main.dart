import 'package:flutter/material.dart';
import 'package:latatrack/views/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LataTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        colorScheme: const ColorScheme.light(
          surface: Color.fromARGB(255, 56, 136, 62),
          onSurface: Colors.white,
          primary:Color.fromARGB(255, 56, 136, 62),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
