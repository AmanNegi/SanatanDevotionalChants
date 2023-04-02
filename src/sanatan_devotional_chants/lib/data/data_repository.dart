import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_devotional_chants/models/lyrics_item.dart';
import 'package:sanatan_devotional_chants/models/music_item.dart';

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  List<MusicItem> _data = [];
  List<LyricsItem> _lyrics = [];

  List<MusicItem> getData() => [..._data];

  LyricsItem getLyrics(String id) {
    var data = _lyrics.where((element) => element.id == id);
    if (data.isEmpty) return LyricsItem(id: id, lyrics: "");

    return data.first;
  }

  List<MusicItem> searchItem(String title) {
    return _data
        .where(
          (element) =>
              element.title.toLowerCase().contains(title.toLowerCase()),
        )
        .toList();
  }

  DataProvider() {
    _initData();
  }

  _initData() async {
    debugPrint("Initilizing Data...");
    _data = await fetchMusicData();
    _lyrics = await fetchLyricsData();
    notifyListeners();
  }
}

Future<List<MusicItem>> fetchMusicData() async {
  List<MusicItem> data = [];
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/data.json"));
  debugPrint(response.body.toString());
  List dataList = json.decode(response.body)["items"];

  for (Map<String, dynamic> e in dataList) {
    data.add(MusicItem.fromMap(e));
  }

  return data;
}

Future<List<LyricsItem>> fetchLyricsData() async {
  List<LyricsItem> data = [];
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/lyrics.json"));
  debugPrint(response.body.toString());
  List dataList = json.decode(response.body)["lyrics"];

  for (Map<String, dynamic> e in dataList) {
    data.add(LyricsItem.fromMap(e));
  }
  return data;
}
