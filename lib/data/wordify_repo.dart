import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadWords(int wLength) async {
  final wData =
      await rootBundle.loadString("assets/data/words${wLength}len.json");
  List<String> wordList =
      (jsonDecode(wData) as List<dynamic>).cast<String>().toList();
  return wordList;
}
