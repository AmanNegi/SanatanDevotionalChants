import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

final assetsAudioPlayer = AssetsAudioPlayer();

Future<void> load(String url) async {
  await assetsAudioPlayer.open(Audio.network(url));
  debugPrint("Audio loaded successfully!");
}

Future<void> playOrPause() async {
  await assetsAudioPlayer.playOrPause();
  debugPrint("Play/Pause Successfull");
}

Future<void> seekAt(Duration duration) async {
  await assetsAudioPlayer.seek(duration);
}

Future<void> disposeAudioPlayer() async {
  await assetsAudioPlayer.stop();
}

getUrl(String url) {
  final gDriveExp = RegExp(r'https://drive\.google\.com/file/d/[A-Za-z0-9]+');

  if (gDriveExp.hasMatch(url)) {
    String id = url.substring(url.lastIndexOf("/d/") + 3, url.length);
    return "https://drive.google.com/uc?export=view&id=$id";
  }

  return url;
}
