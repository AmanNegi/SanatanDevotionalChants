import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sanatan_devotional_chants/globals.dart';

class LyricsPage extends StatelessWidget {
  final String lyrics;
  const LyricsPage({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: false,
        onPressed: () {},
        child: const Icon(Icons.pause),
      ),
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight + 10),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 0.05 * getHeight(context),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: semiDarkColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(lyrics),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white10,
                        child: Icon(
                          MdiIcons.close,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 0.1 * getHeight(context),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: accentLightColor,
          //         radius: 25,
          //         child: const Icon(
          //           Icons.skip_previous_rounded,
          //           color: Colors.white,
          //         ),
          //       ),
          //       StreamBuilder(
          //           stream: assetsAudioPlayer.isPlaying,
          //           builder: (context, snapshot) {
          //             bool isPlaying = snapshot.data ?? false;
          //             return GestureDetector(
          //               onTap: () async {
          //                 playOrPause();
          //               },
          //               child: CircleAvatar(
          //                 radius: 60,
          //                 backgroundColor: semiDarkColor,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(5.0),
          //                   child: CircleAvatar(
          //                     backgroundColor: accentColor,
          //                     radius: 40,
          //                     child: Icon(
          //                       isPlaying
          //                           ? Icons.pause
          //                           : Icons.play_arrow_rounded,
          //                       color: darkColor,
          //                       size: 35,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }),
          //       CircleAvatar(
          //         backgroundColor: accentLightColor,
          //         radius: 25,
          //         child: const Icon(
          //           Icons.skip_next_rounded,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
