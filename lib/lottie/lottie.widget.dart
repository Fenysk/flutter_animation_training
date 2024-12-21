import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  final String fileName;
  final String? clickAnimationFileName;
  final double? width;
  final double? height;
  final void Function(bool)? onHover;
  final VoidCallback? onClick;

  const LottieWidget({
    super.key,
    required this.fileName,
    this.clickAnimationFileName,
    this.width,
    this.height,
    this.onHover,
    this.onClick,
  });

  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _clickController;
  bool _isPlayingClickAnimation = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _clickController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _handleHover(bool isHovering) {
    if (isHovering) {
      _hoverController.forward();
    } else {
      if (_isPlayingClickAnimation) {
        _clickController.reverse().then((_) {
          setState(() {
            _isPlayingClickAnimation = false;
          });
        });
      }
      _hoverController.reverse();
    }
    widget.onHover?.call(isHovering);
  }

  void _handleClick() {
    widget.onClick?.call();
    if (widget.clickAnimationFileName != null) {
      setState(() {
        _isPlayingClickAnimation = true;
      });
      _clickController.forward(from: 0);
    }
  }

  Widget _buildLottieAnimation(String fileName, AnimationController controller) {
    return Lottie.asset(
      'assets/lotties/$fileName',
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
      frameRate: FrameRate.max,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: _handleClick,
        child: _isPlayingClickAnimation && widget.clickAnimationFileName != null ? _buildLottieAnimation(widget.clickAnimationFileName!, _clickController) : _buildLottieAnimation(widget.fileName, _hoverController),
      ),
    );
  }
}
