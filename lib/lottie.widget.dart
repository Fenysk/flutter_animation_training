import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  final String fileName;
  final double? width;
  final double? height;

  const LottieWidget({
    super.key,
    required this.fileName,
    this.width,
    this.height,
  });

  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: Lottie.asset(
        'assets/lotties/${widget.fileName}',
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
        controller: _controller,
      ),
    );
  }
}
