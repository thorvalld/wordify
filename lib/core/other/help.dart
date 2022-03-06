import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordify/utils/custom_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkResponse(
                    radius: 18,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      CupertinoIcons.chevron_back,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "How to play",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.question_square,
                  size: 24,
                  color: Colors.grey,
                ),
                title: Text(
                  "How to play?",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Guess the correct word in a limited number of attempts, each guess must be a valid word. Colors change after each attempt to show how close your answer was.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.backward,
                  size: 22,
                  color: Colors.redAccent,
                ),
                title: Text(
                  "Backspace",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Delete last entered character.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.checkmark,
                  size: 22,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  "Enter",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Submit your attempt.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.keyboard,
                  size: 22,
                  color: Colors.white,
                ),
                title: Text(
                  "Keyboard",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Use in-game keyboard to type.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.square_fill,
                  size: 24,
                  color: CustomColors.cell_correct,
                ),
                title: const Text(
                  "Correct",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Letter is correct and is in the right spot.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.square_fill,
                  size: 24,
                  color: CustomColors.cell_misplaced,
                ),
                title: const Text(
                  "Misplaced",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Letter is correct but is not in the right spot.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.square_fill,
                  size: 24,
                  color: CustomColors.cell_not_exist,
                ),
                title: const Text(
                  "Does not exist",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Letter does not exist in the given word.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              /*ListTile(
                leading: Icon(
                  CupertinoIcons.rectangle_split_3x1_fill,
                  size: 22,
                  color: CustomColors.cell_wrong,
                ),
                title: const Text(
                  "Game lost",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Remaining attempts 0 and word not guessed.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),*/
              ListTile(
                leading: Icon(
                  CupertinoIcons.rectangle_split_3x1_fill,
                  size: 22,
                  color: CustomColors.cell_correct,
                ),
                title: const Text(
                  "Game won",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Remaining attempts 0 and word is guessed.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
