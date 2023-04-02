import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanatan_devotional_chants/data/data_repository.dart';
import 'package:sanatan_devotional_chants/widgets/music_item_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ValueNotifier<String> searchInput = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (e) {
                searchInput.value = e;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                hintText: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: searchInput,
              builder: (context, value, child) {
                if (value.isEmpty || value.length < 3) {
                  return const Center(child: Text("Enter atleast 3 letters"));
                }

                return Consumer(
                  builder: (context, ref, child) {
                    var list = ref.read(dataProvider).searchItem(value);

                    if (list.isEmpty) {
                      return const Center(
                        child: Text("No Item Found"),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return MusicItemWidget(item: list[index]);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
