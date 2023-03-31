import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  List<dynamic> songs = [];
  List<dynamic> data = [];

  DataProvider() {
    _initData();
  }

  _initData() async {
    debugPrint("Initilizing Data...");
    data = await getData();
    songs = await getSongs();
    notifyListeners();
  }
}

getData() async {
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/data.json"));
  debugPrint(response.body.toString());
  return json.decode(response.body)["items"];
}

getSongs() async {
  var response = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AmanNegi/SanatanDevotionalChants/main/data/sounds.json"));
  debugPrint(response.body.toString());
  return json.decode(response.body)["sounds"];
}
