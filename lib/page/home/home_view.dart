import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/page/app_route.dart';
import 'package:discuss_app/page/fragment/account_fragment.dart';
import 'package:discuss_app/page/fragment/explore_fragment.dart';
import 'package:discuss_app/page/fragment/feed_fragment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../fragment/my_topic_fragment.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List menu = [
      {
        'icon': Icons.feed,
        'label': 'Feed',
        'view': const FeedFragment(),
      },
      {
        'icon': Icons.public,
        'label': 'Explore',
        'view': const ExploreFragment(),
      },
      {
        'icon': Icons.library_books,
        'label': 'My Topic',
        'view': const MyTopicFragment(),
      },
      {
        'icon': Icons.account_circle,
        'label': 'Account',
        'view': const AccountFragment(),
      }
    ];

    return Consumer<CHome>(builder: (context, _, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: menu[_.indexMenu]['view'],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRoute.addTopic);
          },
          mini: true,
          tooltip: 'Create New Topic',
          child: const Icon(
            Icons.create,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _.indexMenu,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            _.indexMenu = value;
          },
          items: menu.map((e) {
            return BottomNavigationBarItem(
                icon: Icon(e['icon']), label: e['label']);
          }).toList(),
        ),
      );
    });
  }
}
