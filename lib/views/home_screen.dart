import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import '../services/app_settings.dart';
import '../utils/colors.dart';
import 'index/search_screen.dart';
import 'index/favourite_screen.dart';
import 'index/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _kTabPages = [
    SearchScreen(),
    FavouriteScreen(),
    HistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: _kTabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget bottomNavigation() {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: _tabController.index,
      onTap: _onItemTapped,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      fabLocation: BubbleBottomBarFabLocation.end,
      hasNotch: true,
      hasInk: true, //new, gives a cute ink effect
      inkColor: ColorUtils.white,
      backgroundColor: Provider.of<AppSettings>(context).isDarkMode
          ? ColorUtils.black
          : ColorUtils.baseColor,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: ColorUtils.white,
          icon: Icon(
            Icons.home,
            color: ColorUtils.white,
          ),
          activeIcon: Icon(
            Icons.home,
            color: ColorUtils.white,
          ),
          title: Text("Nyumbani"),
        ),
        BubbleBottomBarItem(
          backgroundColor: ColorUtils.white,
          icon: Icon(
            Icons.star,
            color: ColorUtils.white,
          ),
          activeIcon: Icon(
            Icons.star,
            color: ColorUtils.white,
          ),
          title: Text("Vipendwa"),
        ),
        BubbleBottomBarItem(
          backgroundColor: ColorUtils.white,
          icon: Icon(
            Icons.history,
            color: ColorUtils.white,
          ),
          activeIcon: Icon(
            Icons.history,
            color: ColorUtils.white,
          ),
          title: Text("Historia"),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }
}
