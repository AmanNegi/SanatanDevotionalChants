import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sanatan_devotional_chants/models/music_item.dart';

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  List<MusicItem> _data = [];

  List<MusicItem> getData() => [..._data];

  DataProvider() {
    _initData();
  }

  _initData() async {
    debugPrint("Initilizing Data...");
    _data = await fetchMusicData();
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
