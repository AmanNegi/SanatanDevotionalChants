import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:sanatan_devotional_chants/pages/music_detail_page.dart';
import 'package:sanatan_devotional_chants/widgets/currently_playing_widget.dart';
import 'package:sanatan_devotional_chants/widgets/music_item_widget.dart';

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
        title: const Text("सनातन भक्ति गीत"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: data.getData().map(
                (e) {
                  return MusicItemWidget(item: e);
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
