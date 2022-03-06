class StatModel {
  StatModel({
    this.isDataFirstTime,
    this.totalGamesPlayed,
    this.totalGamesWon,
    this.totalGamesLost,
    this.currentStreak,
    this.bestStreak,
  });

  bool? isDataFirstTime;
  int? totalGamesPlayed;
  int? totalGamesWon;
  int? totalGamesLost;
  int? currentStreak;
  int? bestStreak;
}
