import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:sanatan_devotional_chants/models/music_item.dart';

class MusicDetailPage extends StatefulWidget {
  final MusicItem musicItem;
  const MusicDetailPage({super.key, required this.musicItem});

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.musicItem.title),
      ),
      body: Consumer(
        builder: (_, ref, __) {
          return Stack(
            children: [
              
              Positioned(
                left: 15,
                right: 15.0,
                bottom: 0,
                child: Container(
                  color: darkColor,
                  height: 0.1 * getHeight(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.skip_previous_rounded),
                      ),
                      StreamBuilder(
                          stream: assetsAudioPlayer.isPlaying,
                          builder: (context, snapshot) {
                            bool isPlaying = snapshot.data ?? false;
                            return GestureDetector(
                              onTap: () {
                                playOrPause();
                              },
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: darkColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 50,
                                    child: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow_rounded,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.skip_next_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  SingleChildScrollView _getLyrics(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 30.0,
          bottom: 0.1 * getHeight(context),
        ),
        child: Text(
          ref.read(dataProvider).getLyrics(widget.musicItem.id).lyrics,
        ),
      ),
    );
  }
}
