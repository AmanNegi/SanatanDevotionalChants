import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sanatan_devotional_chants/globals.dart';
import 'package:sanatan_devotional_chants/pages/favourite_page.dart';
import 'package:sanatan_devotional_chants/pages/home_page.dart';
import 'package:sanatan_devotional_chants/pages/search_page.dart';
import 'package:sanatan_devotional_chants/widgets/currently_playing_widget.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int pageIndex = 0;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                HomePage(),
                SearchPage(),
                FavouritePage(),
              ],
            ),
          ),
          const CurrentlyPlayingWidget(),
          Container(
            height: kToolbarHeight,
            color: darkColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getNavBarItem(
                  0,
                  activeIcon: Icons.home,
                  passiveIcon: Icons.home_outlined,
                ),
                _getNavBarItem(
                  1,
                  activeIcon: Icons.search,
                  passiveIcon: Icons.search_outlined,
                ),
                _getNavBarItem(
                  2,
                  activeIcon: MdiIcons.heart,
                  passiveIcon: MdiIcons.heartOutline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getNavBarItem(
    int index, {
    required IconData activeIcon,
    required IconData passiveIcon,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          pageIndex = index;
          _tabController.animateTo(pageIndex);
          setState(() {});
        },
        child: Container(
          color: Colors.transparent,
          child: Icon(
            pageIndex == index ? activeIcon : passiveIcon,
            color: pageIndex != index ? Colors.white : accentColor,
          ),
        ),
      ),
    );
  }
}
