import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Footer();

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "calender",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_rounded),
          label: "analysis",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "settings",
        ),
      ],
      // itemが４つ以上だったら、白飛びしてしまうのでこれで解決する
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
