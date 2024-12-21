import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PlayPauseRiveWidget extends StatefulWidget {
  final String fileName;
  final String loopAnimationName;
  final double? width;
  final double? height;

  const PlayPauseRiveWidget({
    super.key,
    required this.fileName,
    required this.loopAnimationName,
    this.width,
    this.height,
  });

  @override
  State<PlayPauseRiveWidget> createState() => _PlayPauseRiveWidgetState();
}

class _PlayPauseRiveWidgetState extends State<PlayPauseRiveWidget> {
  late RiveAnimationController _loopAnimationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    initRive();
  }

  void initRive() {
    _loopAnimationController = SimpleAnimation(
      widget.loopAnimationName,
      autoplay: false,
    );
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _loopAnimationController.isActive = true;
      } else {
        _loopAnimationController.isActive = false;
      }
    });
  }

  @override
  void dispose() {
    _loopAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: RiveAnimation.asset(
            'assets/rive/${widget.fileName}',
            fit: BoxFit.cover,
            controllers: [
              _loopAnimationController
            ],
            placeHolder: const Center(child: CircularProgressIndicator()),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Row(
            children: [
              IconButton(
                onPressed: _togglePlay,
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
