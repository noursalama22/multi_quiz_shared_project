import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/pages/launch_screen.dart';
import 'package:multi_quiz_s_t_tt9/pages/multiple_q_screen.dart';
import 'package:multi_quiz_s_t_tt9/pages/true_false_q_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/home_screen': (context) => const HomePage(),
        '/launch_screen': (context) => const LaunchScreen(),
        '/level1': (context) => TrueFalseQuiz(),
        '/level2': (context) => const MultiQScreen(),
        // '/description_screen': (context) => LevelDescription(level: level, onpress_btn: onpress_btn),
      },
    );
  }
}
