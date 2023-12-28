import 'package:brick_breaker/colors.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.isGameOver, required this.function});

  final bool isGameOver;
  final function;

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: const Text(
                  "G A M E  O V E R",
                  style: TextStyle(color: AppColors.stick),
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.ball,
                      child: const Text(
                        "PLAY AGAIN",
                        style: TextStyle(color: AppColors.background),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
