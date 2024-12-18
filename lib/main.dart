import 'package:flutter/material.dart';
import 'package:flutter_animation_training/lottie.widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
            child: LottieWidget(
          fileName: 'finder_lottie.json',
          width: 100,
          height: 100,
        )),
      ),
    );
  }
}
