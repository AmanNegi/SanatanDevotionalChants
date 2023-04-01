import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_devotional_chants/models/music_item.dart';

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  Map<String, String> _songs = {};
  List<MusicItem> _data = [];

  List<MusicItem> getData() => [..._data];
  Map getSongs() => {..._songs};

  DataProvider() {
    _initData();
  }

  _initData() async {
    debugPrint("Initilizing Data...");
    _songs = await fetchSongs();
    _data = await fetchMusicData(_songs);
    notifyListeners();
  }
}

Future<List<MusicItem>> fetchMusicData(Map<String, String> songs) async {
  List<MusicItem> data = [];
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/data.json"));
  debugPrint(response.body.toString());
  List dataList = json.decode(response.body)["items"];

  for (Map<String, dynamic> e in dataList) {
    MusicItem item = MusicItem.fromMap(e);
    item.audioUrl = songs[item.id] ?? "";
    data.add(item);
  }

  return data;
}

Future<Map<String, String>> fetchSongs() async {
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/sounds.json"));
  debugPrint(response.body.toString());
  return json.decode(response.body)["sounds"];
}
