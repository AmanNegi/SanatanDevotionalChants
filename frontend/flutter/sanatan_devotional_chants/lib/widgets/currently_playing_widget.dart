import 'package:flutter/material.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:text_scroll/text_scroll.dart';

class CurrentlyPlayingWidget extends StatefulWidget {
  const CurrentlyPlayingWidget({super.key});

  @override
  State<CurrentlyPlayingWidget> createState() => _CurrentlyPlayingWidgetState();
}

class _CurrentlyPlayingWidgetState extends State<CurrentlyPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: assetsAudioPlayer.current,
      builder: (context, snapshot) {
        debugPrint("Playing now ${snapshot.data}");
        bool data = false;
        if (snapshot.hasData && snapshot.data != null) {
          data = snapshot.data == null;

          if (data) return Container();
          return Container(
            height: 0.075 * getHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // darkColor,
                  // semiDarkColor,
                  lightColor,
                  lightColor,
                  // accentLightColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      snapshot.data!.audio.audio.metas.image!.path,
                      fit: BoxFit.cover,
                      width: 0.15 * getWidth(context),
                      height: double.infinity,
                    ),
                  ),
                  // const Icon(MdiIcons.musicCircle),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextScroll(
                            snapshot.data!.audio.audio.metas.title ?? "No Text",
                            delayBefore: const Duration(seconds: 1),
                            fadeBorderSide: FadeBorderSide.both,
                            pauseBetween: const Duration(seconds: 2),
                          ),
                          TextScroll(
                            snapshot.data!.audio.audio.metas.artist ??
                                "No Text",
                            delayBefore: const Duration(seconds: 1),
                            fadeBorderSide: FadeBorderSide.both,
                            pauseBetween: const Duration(seconds: 2),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: assetsAudioPlayer.isPlaying,
                      builder: (context, snapshot) {
                        return IconButton(
                          onPressed: () {
                            playOrPause();
                          },
                          icon: Icon(snapshot.data ?? false
                              ? Icons.pause
                              : Icons.play_arrow_rounded),
                        );
                      }),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
