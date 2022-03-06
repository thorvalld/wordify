import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:wordify/core/leaderboard/leaderboard_local.dart';
import 'package:wordify/core/leaderboard/leaderboard_stats.dart';
import 'package:wordify/core/welcome.dart';
import 'package:wordify/utils/custom_colors.dart';

class Leaderboard extends StatefulWidget {
  final int from;
  const Leaderboard({
    Key? key,
    required this.from,
  }) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  /*void triggerBottomSheet() {
    showModalBottomSheet(
        backgroundColor: CustomColors.main_bg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: InkResponse(
                  radius: 16,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.amber,
                    size: 16,
                  ),
                ),
                title: const Text(
                  'Clear all local games history?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            color: Colors.red.withOpacity(.2),
                            child: Text(
                              "clear all",
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, //3,
      child: Scaffold(
          backgroundColor: CustomColors.main_bg,
          appBar: AppBar(
            backgroundColor: CustomColors.main_bg,
            automaticallyImplyLeading: false,
            centerTitle: false,
            leading: widget.from == 0
                ? InkResponse(
                    radius: 18,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      CupertinoIcons.chevron_back,
                      color: Colors.white,
                    ),
                  )
                : InkResponse(
                    radius: 18,
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WelcomeScreen()));
                    },
                    child: const Icon(
                      CupertinoIcons.home,
                      color: Colors.white,
                    ),
                  ),
            title: const Text(
              "Leaderboard",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            bottom: TabBar(
                physics: const AlwaysScrollableScrollPhysics(),
                enableFeedback: true,
                isScrollable: false,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.amber,
                labelColor: Colors.amber,
                tabs: const [
                  Tab(
                    child: Text('Wordify local games history'),
                  ),
                  /*Tab(
                    child: Text('History'),
                  ),
                  Tab(
                    child: Text('World'),
                  ),*/
                ]),
            /*actions: [
              IconButton(
                onPressed: () {
                  triggerBottomSheet();
                },
                splashRadius: 16,
                splashColor: Colors.amber.withOpacity(.2),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.amber,
                ),
              )
            ],*/
          ),
          body: TabBarView(
            children: [
              Column(
                children: const [
                  Flexible(
                      child: LeaderboardStats(
                          /*totalGamesPlayed: 0,
                    totalGamesWon: 0,
                    totalGamesLost: 0,
                    winRate: 0.0,
                    totalWordsGuessed: 0,
                    totalWordsMissed: 0,
                    currentStreak: 0,
                    bestStreak: 0,*/
                          ))
                ],
              ),
              /*
              Column(
                children: const [
                  Flexible(child: LeaderboardLocal()),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                    Icon(
                      CupertinoIcons.globe,
                      color: Colors.grey.withOpacity(.2),
                      size: 80,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "unavailable",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey.withOpacity(.4),
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              */
            ],
          )),
    );
  }
}
