import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:sanatan_devotional_chants/models/music_item.dart';
import 'package:sanatan_devotional_chants/pages/lyrics_page.dart';
import 'package:text_scroll/text_scroll.dart';

class MusicDetailPage extends StatefulWidget {
  final MusicItem musicItem;
  const MusicDetailPage({super.key, required this.musicItem});

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  @override
  void initState() {
    loadMusic();
    super.initState();
  }

  loadMusic() async {
    var filteredUrl = getUrl(widget.musicItem.audioUrl);
    await load(
      filteredUrl,
      author: widget.musicItem.singer,
      name: widget.musicItem.title,
      image: widget.musicItem.image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.1 * getWidth(context),
        title: TextScroll(
          widget.musicItem.title,
          delayBefore: const Duration(seconds: 1),
          fadeBorderSide: FadeBorderSide.both,
          pauseBetween: const Duration(seconds: 2),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              SizedBox(height: 0.05 * constraints.maxHeight),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                height: 0.475 * constraints.maxHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.musicItem.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //TODO: If text overflows make it flowing
              Container(
                height: 0.15 * constraints.maxHeight,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    TextScroll(
                      widget.musicItem.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      delayBefore: const Duration(seconds: 1),
                      fadeBorderSide: FadeBorderSide.both,
                      pauseBetween: const Duration(seconds: 2),
                    ),
                    Text(widget.musicItem.singer),
                    const Spacer(),
                  ],
                ),
              ),
              // The slider
              Container(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: assetsAudioPlayer.currentPosition,
                      builder: (context, asyncSnapshot) {
                        final Duration currentDuration =
                            asyncSnapshot.data ?? const Duration(seconds: 0);
                        Duration totalDuration;
                        try {
                          totalDuration =
                              assetsAudioPlayer.current.value!.audio.duration;
                        } catch (e) {
                          debugPrint("Going For Fallback Duration");
                          totalDuration = const Duration(seconds: 1);
                        }
                        return Column(
                          children: [
                            Slider(
                              inactiveColor: semiDarkColor,
                              onChanged: (newChange) {
                                var duration =
                                    Duration(milliseconds: newChange.toInt());
                                print("New Change $duration");
                                seekAt(duration);
                              },
                              value: currentDuration.inMilliseconds * 1.0,
                              min: 0.0,
                              max: totalDuration.inMilliseconds * 1.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Text(_getDuration(currentDuration)),
                                  const Spacer(),
                                  Text(_getDuration(totalDuration)),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // The Playing Controls Widget
              Container(
                color: darkColor,
                height: 0.1 * getHeight(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: accentLightColor,
                      radius: 25,
                      child: const Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder(
                        stream: assetsAudioPlayer.isPlaying,
                        builder: (context, snapshot) {
                          bool isPlaying = snapshot.data ?? false;
                          return GestureDetector(
                            onTap: () async {
                              playOrPause();
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: semiDarkColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  backgroundColor: accentColor,
                                  radius: 40,
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow_rounded,
                                    color: darkColor,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    CircleAvatar(
                      backgroundColor: accentLightColor,
                      radius: 25,
                      child: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (_, ref, __) {
                  var lyrics = ref
                      .read(dataProvider)
                      .getLyrics(widget.musicItem.id)
                      .lyrics;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: semiDarkColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: [
                        _getLyrics(lyrics),
                        Positioned(
                          right: 15,
                          top: 15,
                          child: GestureDetector(
                            onTap: () {
                              goToPage(context, LyricsPage(lyrics: lyrics));
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white10,
                              child: Icon(
                                MdiIcons.arrowExpand,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  _getLyrics(String lyrics) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "LYRICS",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 0.025 * getHeight(context),
          ),
          Text(
            lyrics,
            overflow: TextOverflow.ellipsis,
            maxLines: getHeight(context) ~/ (0.07 * getHeight(context)),
          ),
        ],
      ),
    );
  }
}

String _getDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
