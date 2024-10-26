import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.onChanged, required this.initialIndex});

  final Function(int) onChanged;
  final ValueNotifier<int> initialIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _currentIndex;

  final List<Map<String, dynamic>> navItemsData = [
    {'title': 'Home', 'icon': Icons.home_outlined},
    {'title': 'Search', 'icon': Icons.search_outlined},
    {'title': 'Settings', 'icon': Icons.settings_outlined},
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.initialIndex,
        builder: (context, value, _) {
          _currentIndex = widget.initialIndex.value;
          return Container(
            height: 70,
            color: Colors.blue,
            child: Row(
              children: List.generate(
                  navItemsData.length,
                  (index) => navItem(index, navItemsData[index]['title'],
                      navItemsData[index]['icon'],
                      isSelected: index == _currentIndex)),
            ),
          );
        });
  }

  Expanded navItem(int index, String title, IconData icon,
      {bool isSelected = false}) {
    final color = isSelected ? Colors.white : Colors.white.withOpacity(0.6);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            Text(title, style: TextStyle(color: color))
          ],
        ),
      ),
    );
  }

  void onTap(index) {
    widget.onChanged(index);
    _currentIndex = index;
    setState(() {});
  }
}
