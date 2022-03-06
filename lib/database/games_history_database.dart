// ignore_for_file: prefer_const_declarations

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordify/models/game.dart';

class GamesHistoryDtabase {
  static final GamesHistoryDtabase ghdbInstance = GamesHistoryDtabase._init();

  static Database? _database;

  GamesHistoryDtabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('local_games_history.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database database, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await database.execute('''
CREATE TABLE $tableLocalGamesHistory (
  ${GameDetailsFields.id} $idType,
  ${GameDetailsFields.playerName} $textType, 
  ${GameDetailsFields.playedAt} $intType, 
  ${GameDetailsFields.correctWord} $textType, 
  ${GameDetailsFields.isWon} $boolType,
  ${GameDetailsFields.guessedAt} $intType, 
  ${GameDetailsFields.wordDifficulty} $intType, 
  ${GameDetailsFields.attemptsDifficulty} $intType,
  ${GameDetailsFields.timeToComplete} $intType,  
    )
    ''');
  }

  Future<GameDetails> create(GameDetails game) async {
    final database = await ghdbInstance.database;
    final id =
        await database.insert(tableLocalGamesHistory, game.fieldsToJSON());
    return game.copy(id: id);
  }

  Future<GameDetails> readOneById(int id) async {
    final database = await ghdbInstance.database;
    final maps = await database.query(tableLocalGamesHistory,
        columns: GameDetailsFields.values,
        where: '${GameDetailsFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return GameDetails.fieldsFromJSON(maps.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  Future<List<GameDetails>> readAll() async {
    final database = await ghdbInstance.database;
    final orderByTimeAsc = '${GameDetailsFields.playedAt} ASC';
    final result =
        await database.query(tableLocalGamesHistory, orderBy: orderByTimeAsc);
    return result.map((json) => GameDetails.fieldsFromJSON(json)).toList();
  }

  //UPDATE NOT NEEDED
  //DELETE ONE NOT NEEDED

  clearLocalLeaderboard() async {
    Database database = await ghdbInstance.database;
    return await database.rawDelete("Delete from $tableLocalGamesHistory");
  }

  Future close() async {
    final database = await ghdbInstance.database;
    database.close();
  }
}
