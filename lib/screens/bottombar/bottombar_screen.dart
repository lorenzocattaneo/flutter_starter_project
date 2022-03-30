import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/authentication_provider.dart';
import 'package:flutter_starter_project/data/models/post.dart';
import 'package:flutter_starter_project/screens/bottombar/posts/post_detail_screen.dart';
import 'package:flutter_starter_project/screens/bottombar/posts/posts_screen.dart';
import 'package:flutter_starter_project/screens/bottombar/tab/tab_screen.dart';
import 'package:flutter_starter_project/widgets/scaffold_screen.dart';

class BottombarScreen extends StatefulWidget {
  const BottombarScreen({Key? key}) : super(key: key);

  @override
  State<BottombarScreen> createState() => _BottombarScreenState();
}

class _BottombarScreenState extends State<BottombarScreen> {
  int _tabIndex = 0;
  final tabRouteDelegates = [
    BeamerDelegate(
        initialPath: '/posts/list',
        locationBuilder: RoutesLocationBuilder(
          routes: {
            '/posts/list': (context, state, data) => const PostsScreen(),
            '/posts/detail': (context, state, data) {
              return PostDetailScreen(post: data as Post);
            },
          },
        )),
  ];

  @override
  void initState() {
    super.initState();
    tabRouteDelegates.forEach((e) => e.addListener(() {
          setState(() {
            _tabIndex = _tabIndex;
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldScreen(
      title: "Home",
      appBar: (_, __) => AppBar(
        leading: Builder(
          builder: (context) {
            if ((_tabIndex == 0) && tabRouteDelegates[_tabIndex].canBeamBack) {
              return BackButton(onPressed: () {
                tabRouteDelegates[_tabIndex].beamBack();
              });
            }
            return Container();
          },
        ),
        title: Text("Home"),
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
                onPressed: () async {
                  await ref.read(authenticationProvider.notifier).logout();
                  Beamer.of(context).popToNamed("/login");
                },
                icon: Icon(Icons.logout)),
          )
        ],
        elevation: 0,
      ),
      bottomNavigationBar: (_, __) => BottomNavigationBar(
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Posts"),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: "Tab")
        ],
        onTap: (index) {
          if (index != _tabIndex) {
            setState(() => _tabIndex = index);
            if (_tabIndex == 0)
              tabRouteDelegates[_tabIndex].update(rebuild: false);
          }
        },
      ),
      pageBuilder: (context, ref, child) => SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: [
            Beamer(routerDelegate: tabRouteDelegates[0]),
            const TabScreen()
          ],
        ),
      ),
    );
  }
}
