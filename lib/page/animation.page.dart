import 'package:flutter/material.dart';
import 'package:flutter_animation_training/lottie/lottie.widget.dart';
import 'package:flutter_animation_training/lottie/lottie-names.dart';
import 'package:flutter_animation_training/rive/artboard-rive.widget.dart';
import 'package:flutter_animation_training/rive/rive-names.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLottie(context),
                const SizedBox(width: 32),
                buildRive(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildRive(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Rive',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ArtBoardRiveWidget(
              fileName: RiveNames.finder,
              stateMachineName: 'Finder',
              width: 100,
              height: 100,
              onClick: () => print('Finder clicked !'),
              onHover: (hover) => print('Finder hover state : $hover !'),
            ),
          ],
        ),
      ],
    );
  }

  Column buildLottie(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Lottie',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieWidget(
              fileName: LottieNames.finder,
              clickAnimationFileName: LottieNames.finder_smile,
              width: 100,
              height: 100,
              onHover: (hover) {
                if (hover)
                  print('Lottie hovered !');
                else
                  print('Lottie not hovered.');
              },
              onClick: () {
                print('Lottie clicked !');
              },
            ),
          ],
        ),
      ],
    );
  }
}
