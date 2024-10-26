import 'package:flutter/material.dart';
import 'package:test_project/main.dart';

import 'widgets/custom_bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _page1 = GlobalKey<NavigatorState>();
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);

  final List<Widget> _pages = const [
    Homepage(),
    Search(),
    Settings(),
  ];

  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: Scaffold(
        body: Navigator(
          key: _page1,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const Homepage(),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          initialIndex: _currentIndexNotifier,
          onChanged: onIndexChanged,
        ),
      ),
    );
  }

  PageRouteBuilder _noAnimationPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  void onPopInvoked(didPop) {
    if (_page1.currentState?.canPop() ?? false) {
      _page1.currentState?.pop();
      canPop = true;
      _currentIndexNotifier.value = 0;
      setState(() {});
    }
  }

  void onIndexChanged(index) {
    if (_currentIndexNotifier.value == index) return;
    if (_currentIndexNotifier.value == 0) {
      _page1.currentState?.push(_noAnimationPageRoute(_pages[index]));
    } else {
      _page1.currentState
          ?.pushReplacement(_noAnimationPageRoute(_pages[index]));
    }

    canPop = false;
    _currentIndexNotifier.value = index;
    setState(() {});
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Homepage',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}

class PagePushed extends StatelessWidget {
  const PagePushed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page pushed')),
      body: const Center(
          child: Text(
        'Page pushed',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () => navigatorKey.currentState?.push(
                  MaterialPageRoute(builder: (context) => const PagePushed())),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.blue),
              ))),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Settings',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
