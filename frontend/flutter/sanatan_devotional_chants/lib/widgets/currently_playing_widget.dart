import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/globals.dart';

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
                  Colors.black,
                  darkColor,
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
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(5.0),
                  //   child: Image.asset(
                  //     snapshot.data!.audio.audio.metas.image!.path,
                  //   ),
                  // ),
                  const Icon(MdiIcons.musicCircle),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!.audio.audio.metas.title ?? "No Text",
                            maxLines: 1,
                          ),
                          Text(
                            snapshot.data!.audio.audio.metas.artist ??
                                "No Text",
                            maxLines: 1,
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
