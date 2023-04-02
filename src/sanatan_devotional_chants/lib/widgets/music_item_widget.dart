import 'package:flutter/material.dart';
import 'package:sanatan_devotional_chants/models/music_item.dart';
import 'package:sanatan_devotional_chants/pages/music_detail_page.dart';

import '../globals.dart';

class MusicItemWidget extends StatelessWidget {
  final MusicItem item;
  const MusicItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        goToPage(context, MusicDetailPage(musicItem: item));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(item.image),
      ),
      title: Text(item.title),
      subtitle: Text(item.singer),
    );
  }
}
