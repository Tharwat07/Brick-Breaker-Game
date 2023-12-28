import 'dart:async';
import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/cover_screen.dart';
import 'package:brick_breaker/palyer.dart';
import 'package:brick_breaker/select_level_screen.dart';
import 'package:brick_breaker/winner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bricks.dart';
import 'colors.dart';
import 'game_over_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.difficulty});

  final String difficulty; // 'easy', 'medium', or 'hard'

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool hasWon = false;

  // ball variables
  double ballX = 0;
  double ballY = 0;
  late double ballXIncrements;
  late double ballYIncrements;
  var ballyDirection = direction.UP;
  var ballXDirection = direction.LEFT;

  // game settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  // player variables
  double playerX = -0.2;
  late double playerWidth;

  // brick variable
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.8;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGroup = 0.01;
  static int numberOfBrick = 3;

  static double wallGap =
      0.5 * (2 - numberOfBrick * brickWidth) - (numberOfBrick - 1) * brickGroup;

  bool brickBroken = false;

  late List myBrick;

  void initializeBricks() {
    double brickX = firstBrickX;
    double brickY = firstBrickY;

    myBrick = []; // Clear the existing bricks

    int rows;
    int bricksPerRow;

    switch (widget.difficulty) {
      case 'easy':
        rows = 2;
        ballXIncrements = 0.01;
        ballYIncrements = 0.01;
        bricksPerRow = 8;
        playerWidth = 0.4;
        break;
      case 'medium':
        rows = 3;
        playerWidth = 0.3;
        ballXIncrements = 0.02;
        ballYIncrements = 0.02;
        bricksPerRow =
            6; // Update the number of bricks per row for medium difficulty
        break;
      case 'hard':
        rows = 4;
        ballXIncrements = 0.03;
        ballYIncrements = 0.03;
        playerWidth = 0.2;
        bricksPerRow =
            6; // Update// the number of bricks per row for hard difficulty
        break;
      default:
        rows = 2;
        bricksPerRow = 8;
    }

    double totalBrickWidth =
        bricksPerRow * brickWidth + (bricksPerRow - 1) * brickGroup;
    double gapX = (2 - totalBrickWidth) / 2;

    for (int row = 0; row < rows; row++) {
      for (int i = 0; i < bricksPerRow; i++) {
        if (brickX + brickWidth <= 1.0 && brickX >= -1.0) {
          // Check if the brick is within the screen
          myBrick.add([brickX, brickY, false]);
        }
        brickX += brickWidth + brickGroup;
      }
      // Adjust starting x-coordinate for the second row to center it
      brickX = firstBrickX +
          gapX * ((bricksPerRow - 1) / 2); // Centers the second row
      brickY += brickHeight + brickGroup;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeBricks();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10),
    )..addListener(_onTick);
  }

  void _onTick() {
    if (hasGameStarted && !isGameOver && !hasWon) {
      updateDirection();
      moveBall();
      if (isPlayerDead()) {
        _controller.stop();
        setState(() {
          isGameOver = true;
        });
      }
      checkForBrokenBricks();

      // Check for winning conditions
      if (myBrick.every((brick) => brick[2])) {
        _controller.stop();
        setState(() {
          hasWon = true;
        });
      }
    }
  }

  void startGame() {
    hasGameStarted = true;
    _controller.repeat();
  }

  void resetGame() {
    // Stop the animation controller
    _controller.stop();

    // Reset ball and player positions
    setState(() {
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      isGameOver = false;
      hasGameStarted = false;
      hasWon = false;

      // Reinitialize bricks
      initializeBricks();
    });

    // Restart the animation controller
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == direction.RIGHT) {
        ballX += ballXIncrements;
      } else if (ballXDirection == direction.LEFT) {
        ballX -= ballXIncrements;
      }

      if (ballyDirection == direction.DOWN) {
        ballY += ballYIncrements;
      } else if (ballyDirection == direction.UP) {
        ballY -= ballYIncrements;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBrick.length; i++) {
      if (ballX >= myBrick[i][0] &&
          ballX <= myBrick[i][0] + brickWidth &&
          ballY >= myBrick[i][1] &&
          ballY <= myBrick[i][1] + brickHeight &&
          myBrick[i][2] == false) {
        setState(() {
          myBrick[i][2] = true;

          // Change direction based on the side hit
          if (ballX < myBrick[i][0] || ballX > myBrick[i][0] + brickWidth) {
            ballXDirection = (ballXDirection == direction.LEFT)
                ? direction.RIGHT
                : direction.LEFT;
          } else {
            ballyDirection = (ballyDirection == direction.UP)
                ? direction.DOWN
                : direction.UP;
          }
        });
      }
    }
  }

  // update directions
  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballyDirection = direction.UP;
      } else if (ballY <= -1) {
        ballyDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

// move player left
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  // move player right
  void moveRight() {
    // print("Before moveRight: playerX = $playerX");
    setState(() {
      if (!((playerX + playerWidth) >= 1)) {
        playerX += 0.2;
      }
    });
    // print("After moveRight: playerX = $playerX");
  }


  // move player left
  void moveLeft2() {
    setState(() {
      if (!(playerX - 0.01 < -1)) {
        playerX -= 0.01;
      }
    });
  }

  // move player right
  void moveRight2() {
    // print("Before moveRight: playerX = $playerX");
    setState(() {
      if (!((playerX + playerWidth) >= 1)) {
        playerX += 0.01;
      }
    });
    // print("After moveRight: playerX = $playerX");
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: hasWon
          ? WinnerWidget(
              function: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectLevelScreen(),
                  ),
                );
              },
            )
          : GestureDetector(
              onTap: startGame,
              onHorizontalDragUpdate: (details) {
                // Detect horizontal drag and move the player accordingly
                if (details.primaryDelta! > 0) {
                  moveRight2();
                } else if (details.primaryDelta! < 0) {
                  moveLeft2();
                }
              },
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Center(
                  child: Stack(
                    children: [
                      // tap to play
                      CoverScreen(
                        hasGameStarted: hasGameStarted,
                        isGameOver: isGameOver,
                      ),

                      //Game over
                      GameOver(
                        isGameOver: isGameOver,
                        function: resetGame,
                      ),

                      // ball
                      MyBall(
                        ballX: ballX,
                        ballY: ballY,
                        hasGameStarted: hasGameStarted,
                        isGameOver: isGameOver,
                      ),
                      // the player
                      MyPlayer(
                        playerWidth: playerWidth,
                        playerX: playerX,
                      ),
                      // bricks

                      for (int i = 0; i < myBrick.length; i++)
                        Bricks(
                          brickX: myBrick[i][0],
                          brickY: myBrick[i][1],
                          brickWidth: brickWidth,
                          brickHeight: brickHeight,
                          brickBroken: myBrick[i][2],
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
