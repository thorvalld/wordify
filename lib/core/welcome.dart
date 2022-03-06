import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordify/core/game/game_screen.dart';
import 'package:wordify/core/settings/settings.dart';
import 'package:wordify/utils/custom_colors.dart';

import 'other/help.dart';
import 'leaderboard/leaderboard.dart';

TextEditingController _playerNameCtrl = TextEditingController();

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setPlayerName() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('player_name', _playerNameCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 32, right: 32, top: 22),
                  child: Image.asset(
                    "assets/images/wordify-logo.png",
                    height: 200,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustomColors.main_bg.withOpacity(.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _playerNameCtrl,
                                cursorColor: Colors.amber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.amber),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(CupertinoIcons.person,
                                        color: Colors.amber),
                                    hintText: "Enter Player name",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const DifficultyToggle(),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CupertinoButton(
                            child: const Text(
                              "START GAME",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setPlayerName();
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const GameScreen()));
                            }))
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const Leaderboard(
                          from: 0,
                        ),
                      ),
                    );
                  },
                  tooltip: "leaderboard",
                  splashRadius: 18,
                  icon: const Icon(
                    CupertinoIcons.chart_bar,
                    size: 22,
                    color: Colors.amber,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                  tooltip: "settings",
                  splashRadius: 18,
                  icon: const Icon(
                    CupertinoIcons.gear,
                    size: 22,
                    color: Colors.amber,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const HelpScreen(),
                      ),
                    );
                  },
                  tooltip: "help",
                  splashRadius: 18,
                  icon: const Icon(
                    CupertinoIcons.info_circle,
                    size: 22,
                    color: Colors.amber,
                  )),
            ],
          ),
          const SizedBox(
            height: 26,
          )
        ],
      )),
    );
  }
}
