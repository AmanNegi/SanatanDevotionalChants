import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:sanatan_devotional_chants/pages/music_detail_page.dart';
import 'package:sanatan_devotional_chants/widgets/currently_playing_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(dataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: data.getData().map(
                (e) {
                  return ListTile(
                    onTap: () async {
                      // var filteredUrl = getUrl(e.audioUrl);
                      // await load(
                      //   filteredUrl,
                      //   author: e.singer,
                      //   name: e.title,
                      // );
                      goToPage(context, MusicDetailPage(musicItem: e));
                    },
                    leading: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                    title: Text(e.title),
                    subtitle: Text(e.singer),
                  );
                },
              ).toList(),
            ),
          ),
          const CurrentlyPlayingWidget(),
        ],
      ),
    );
  }
}
