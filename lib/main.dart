// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_calendar/pages/top_page.dart';
import 'package:training_calendar/pages/memo_page.dart';

// 最初にMyAppを実行する
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// 初期設定
class MyApp extends StatelessWidget {
  static const String _title = '筋トレアプリ';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const MyStatefulWidget(title: _title),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// 状態管理
class MyStatefulWidget extends StatefulWidget {
  final String title;

  const MyStatefulWidget({Key? key, required this.title}) : super(key: key);

  @override
  // 更新
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // 初期状態での選択は左のタブ
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // ページ1の画面
    const TopPage(),
    // ページ2の画面
    // Page2(),
    // ページ3の画面
    MemoPage(),
    // ページ4の画面
    Page4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // 下のナビゲーションボタン
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "calender",
          ),
          // todo : 画面がないのでエラーになるのでコメントアウト
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
        // 選択をナビゲーションアイコンに反映
        currentIndex: _selectedIndex,
        // 選択したときはオレンジ色にする
        selectedItemColor: Colors.amber[800],
        // タップできるように
        onTap: _onItemTapped,
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'ページ3',
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'ページ4',
    );
  }
}
