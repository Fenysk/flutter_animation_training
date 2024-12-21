import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class ArtBoardRiveWidget extends StatefulWidget {
  final String fileName;
  final String stateMachineName;
  final double? width;
  final double? height;
  final void Function(bool)? onHover;
  final VoidCallback? onClick;

  const ArtBoardRiveWidget({
    super.key,
    required this.fileName,
    required this.stateMachineName,
    this.width,
    this.height,
    this.onHover,
    this.onClick,
  });

  @override
  State<ArtBoardRiveWidget> createState() => _ArtBoardRiveWidgetState();
}

class _ArtBoardRiveWidgetState extends State<ArtBoardRiveWidget> {
  bool get isPlaying => _riveController?.isActive ?? false;

  Artboard? _riveArtBoard;
  StateMachineController? _riveController;
  SMIInput<bool>? _hoverInput;
  SMIInput<bool>? _clickInput;

  @override
  void initState() {
    super.initState();
    initRive();
  }

  void initRive() async {
    rootBundle.load('assets/rive/${widget.fileName}').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, widget.stateMachineName);

      if (controller != null) {
        artboard.addController(controller);
        _hoverInput = controller.findInput('hover');
        _clickInput = controller.findInput('click');
      }

      setState(() => _riveArtBoard = artboard);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleHover(bool isHovering) {
    _hoverInput?.value = isHovering;
    widget.onHover?.call(isHovering);
  }

  void _handleTapDown() {
    _clickInput?.value = true;
    widget.onClick?.call();
  }

  void _handleTapUp() {
    _clickInput?.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtBoard == null
        ? SizedBox.shrink()
        : SizedBox(
            width: widget.width,
            height: widget.height,
            child: MouseRegion(
              onEnter: (_) => _handleHover(true),
              onExit: (_) => _handleHover(false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTapDown: (_) => _handleTapDown(),
                onTapUp: (_) => _handleTapUp(),
                onTapCancel: () => _handleTapUp(),
                child: Rive(
                  fit: BoxFit.contain,
                  artboard: _riveArtBoard!,
                ),
              ),
            ),
          );
  }
}
