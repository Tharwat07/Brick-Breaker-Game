import 'package:brick_breaker/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class SelectLevelScreen extends StatefulWidget {
  const SelectLevelScreen({super.key});

  @override
  _SelectLevelScreenState createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends State<SelectLevelScreen> {
  String selectedDifficulty = 'easy'; // Default difficulty

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.x), // Change the color here
              ),
              onPressed: () => _showDifficultyDialog(context),
              child: Text(
                'Select Difficulty',
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
            ),
            const SizedBox(height: 20),
            Text('Selected Difficulty: $selectedDifficulty'),
          ],
        ),
      ),
    );
  }

  Future<void> _showDifficultyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Select Difficulty',
            style: GoogleFonts.pressStart2p(fontSize: 10),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                _selectDifficulty('easy');
                Navigator.pop(context);
                _navigateToHome();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset("assets/img.png")),
                  ),
                  Text('Easy'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _selectDifficulty('medium');
                Navigator.pop(context);
                _navigateToHome();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset("assets/img_1.png")),
                  ),
                  const Text('Medium'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _selectDifficulty('hard');
                Navigator.pop(context);
                _navigateToHome();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset("assets/img_2.png")),
                  ),
                  const Text('Hard'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectDifficulty(String difficulty) {
    setState(() {
      selectedDifficulty = difficulty;
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(difficulty: selectedDifficulty),
      ),
    );
  }
}
