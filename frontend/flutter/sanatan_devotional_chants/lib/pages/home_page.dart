import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/data/data.dart';

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
        body: ListView(
          children: data.data.map((e) {
            return ListTile(
              onTap: () async {
                String soundId = e["soundId"].toString();
                print(soundId);
                print(data.songs.toString());

                for (Map e in data.songs) {
                  if (e.keys.first == soundId) {
                    var filteredUrl = getUrl(e.values.first);
                    await load(filteredUrl);
                    await playOrPause();
                  }
                }
              },
              leading: const Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              title: Text(e['name']),
              subtitle: Text(e['author']),
            );
          }).toList(),
        ));
  }
}
