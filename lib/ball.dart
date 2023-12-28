import 'package:avatar_glow/avatar_glow.dart';
import 'package:brick_breaker/colors.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  const MyBall(
      {super.key,
      required this.ballX,
      required this.ballY,
      required this.isGameOver,
      required this.hasGameStarted});

  final double ballX;
  final double ballY;
  final bool isGameOver;

  final bool hasGameStarted;

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: AppColors.ball,
                shape: BoxShape.circle,
              ),
            ),
          )
        : Container(

            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              repeat: true,
              glowColor: AppColors.stick,
              glowRadiusFactor: 2,
              child: Material(
                elevation: 0.8,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: AppColors.ball,
                  radius: 7,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.ball,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
