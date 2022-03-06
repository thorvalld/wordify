import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardStats extends StatefulWidget {
  const LeaderboardStats({
    Key? key,
  }) : super(key: key);

  @override
  State<LeaderboardStats> createState() => _LeaderboardStatsState();
}

class _LeaderboardStatsState extends State<LeaderboardStats> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<int> totalGamesPlayed;
  late Future<int> totalGamesWon;
  late Future<int> totalGamesLost;
  late Future<int> totalWordsGuessed;
  late Future<int> totalWordsMissed;
  late Future<int> currentStreak;
  late Future<int> bestStreak;
  late Future<double> winRate;
  late Future<String> allTimeBest;

  @override
  void initState() {
    super.initState();
    totalGamesPlayed = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('games_played') ?? 0;
    });
    totalGamesWon = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('games_won') ?? 0;
    });
    totalGamesLost = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('games_lost') ?? 0;
    });
    currentStreak = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('current_streak') ?? 0;
    });
    bestStreak = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('best_streak') ?? 0;
    });
    winRate = _prefs.then((SharedPreferences prefs) {
      return prefs.getDouble('win_rate') ?? 0.0;
    });
    allTimeBest = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('all_time_best_str') ?? '-- min & -- sec';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const ListTile(
                enabled: false,
                title: Text(
                  "General statistics",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    margin: const EdgeInsets.only(
                      right: 8,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.indigo.withOpacity(.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "GAMES PLAYED",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<int>(
                                future: totalGamesPlayed,
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    default:
                                      if (snapshot.hasError) {
                                        return const Text(
                                          '0',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    margin: const EdgeInsets.only(
                      left: 8,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.indigo.withOpacity(.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "WIN RATE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<double>(
                                future: winRate,
                                builder:
                                    (context, AsyncSnapshot<double> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    default:
                                      if (snapshot.hasError) {
                                        return const Text(
                                          '0.00%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        String snappedDouble =
                                            snapshot.data.toString();
                                        List<String> strWr =
                                            snappedDouble.split(".");
                                        String partA = strWr[0];
                                        String partB = strWr[1].substring(0, 1);
                                        return Text(
                                          '$partA.$partB%',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    margin: const EdgeInsets.only(
                      right: 8,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.teal.withOpacity(.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "GAMES WON",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<int>(
                                future: totalGamesWon,
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    default:
                                      if (snapshot.hasError) {
                                        return const Text(
                                          '0',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    margin: const EdgeInsets.only(
                      left: 8,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.redAccent.withOpacity(.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "GAMES LOST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<int>(
                                future: totalGamesLost,
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    default:
                                      if (snapshot.hasError) {
                                        return const Text(
                                          '0',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const ListTile(
                enabled: false,
                title: Text(
                  "Top time",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
            FutureBuilder<String>(
                future: allTimeBest,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: const ListTile(
                          leading: Icon(
                            CupertinoIcons.clock,
                            color: Colors.grey,
                          ),
                          title: Text(
                            'loading...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ));
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.clock,
                            color: Colors.green,
                          ),
                          title: Text(
                            snapshot.data!,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ));
                  }
                }),
            /*
            const ListTile(
                enabled: false,
                title: Text(
                  "Last 5 games",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return WordifyInProgress(
                      displayIcon: CupertinoIcons.clock,
                      displayMessage: '$index');
                })
            */
          ],
        ),
      ),
    );
  }
}
