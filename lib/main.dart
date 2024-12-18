import 'package:flutter/material.dart';
import 'package:flutter_animation_training/lottie/lottie-names.dart';
import 'package:flutter_animation_training/lottie/lottie.widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LottieWidget(
            fileName: LottieNames.finder,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
