import 'package:brick_breaker/colors.dart';
import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen(
      {super.key, required this.hasGameStarted, required this.isGameOver});

  final bool hasGameStarted;
  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.5),
            child: Text(
              isGameOver ? '' : "BRICK BREAKER",
              style: TextStyle(
                  color: AppColors.stick.withOpacity(0.3), fontSize: 25),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.5),
                child: const Text(
                  "BRICK BREAKER",
                  style: TextStyle(color: AppColors.ball, fontSize: 25),
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: const Text(
                  "Tap To Play",
                  style: TextStyle(color: AppColors.stick),
                ),
              ),
            ],
          );
  }
}
