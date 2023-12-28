import 'package:brick_breaker/colors.dart';
import 'package:flutter/material.dart';

class Bricks extends StatelessWidget {
  const Bricks(
      {super.key,
      required this.brickX,
      required this.brickY,
      required this.brickWidth,
      required this.brickHeight,
      required this.brickBroken});

  final double brickX;
  final double brickY;
  final double brickWidth;

  final double brickHeight;
  final bool brickBroken;

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? const SizedBox()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: AppColors.stick,
              ),
            ),
          );
  }
}
