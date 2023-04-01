import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';

void main() {
  test("Test if we are getting data from", () async {
    await Future.delayed(const Duration(seconds: 1));

    await fetchMusicData(await fetchSongs());
    await Future.delayed(const Duration(seconds: 2));
  });
  test("Test if getURL works", () async {
    await Future.delayed(const Duration(seconds: 1));
    var data = getUrl(
        "https://drive.google.com/file/d/1ke7L-lMDiZ2xL0pevf55ziL3sjWdxqmp");
    print(data);
    await Future.delayed(const Duration(seconds: 2));
  });
}
