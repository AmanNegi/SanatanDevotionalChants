import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/audio_helper.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';

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
          children: data.getData().map((e) {
            return ListTile(
              onTap: () async {
                String soundId = e.id.toString();
                print(soundId);
                print(data.getSongs().toString());

                var filteredUrl = getUrl(e.audioUrl);
                await load(
                  filteredUrl,
                  author: e.singer,
                  name: e.title,
                );
              },
              leading: const Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              title: Text(e.title),
              subtitle: Text(e.singer),
            );
          }).toList(),
        ));
  }
}
