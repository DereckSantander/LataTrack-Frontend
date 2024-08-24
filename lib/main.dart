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
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF27AE60), // Verde lima
          secondary: Color(0xFFC0392B), // Rojo tomate
          surface: Color(0xFF34495E), // Gris grafito
          onPrimary: Colors.white, // Texto sobre colores primarios
          onSecondary: Colors.white, // Texto sobre colores secundarios
          onSurface: Colors.white, // Texto sobre superficies
        ),
        scaffoldBackgroundColor: const Color(0xFF2C3E50), // Fondo de todas las pantallas
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF34495E), // Fondo de la AppBar
          iconTheme: IconThemeData(color: Colors.white), // Color de los íconos en la AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Estilo del texto en la AppBar
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF27AE60), // Color de fondo de los botones
          textTheme: ButtonTextTheme.primary, // Texto sobre los botones
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Texto principal
          bodyMedium: TextStyle(color: Colors.white), // Texto secundario
          headlineLarge: TextStyle(color: Colors.white), // Titulares
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, // Cambia el color del cursor globalmente
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
