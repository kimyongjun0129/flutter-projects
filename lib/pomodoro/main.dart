import 'package:flutter/material.dart';
import 'package:toonflix/pomodoro/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE64D3D),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
          ),
        ),
        cardColor: const Color(0xFFE64D3D),
      ),
      home: const HomeScreen(),
    );
  }
}
