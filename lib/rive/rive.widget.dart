import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveWidget extends StatefulWidget {
  final String fileName;
  final double? width;
  final double? height;
  final void Function(bool)? onHover;
  final VoidCallback? onClick;
  final List<String> animations;

  const RiveWidget({
    super.key,
    required this.fileName,
    this.width,
    this.height,
    this.onHover,
    this.onClick,
    this.animations = const [],
  });

  @override
  State<RiveWidget> createState() => _RiveWidgetState();
}

class _RiveWidgetState extends State<RiveWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _handleHover(bool isHovering) {
    widget.onHover?.call(isHovering);
  }

  void _handleClick() {
    widget.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: _handleClick,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: RiveAnimation.asset(
            'assets/rive/${widget.fileName}',
            animations: widget.animations,
            fit: BoxFit.cover,
            placeHolder: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
