// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// 最初にMyAppを実行する
void main() => runApp(const MyApp());

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
    const Page1(),
    // ページ2の画面
    Page2(),
    // ページ3の画面
    Page3(),
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

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

// （ページ1）左ページ
class _Page1State extends State<Page1> {
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  final textfieldsController = TextEditingController();

  final List<String> _textList = [];
  String _text = '';

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    textfieldsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    void _handleText(String e) {
      print("call _handleText");
      print("_text = $_text");
      // ignore: prefer_is_empty
      if ((e.length > 0)) {
        // 入力値があるなら、それを反映する。
        setState(() {
          _text = e;
        });
      } else {
        setState(() {
          _text = '';
        });
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Spacer(
            flex: 2,
          ),
          Text("_text = $_textList"),
          Text("_text = $_text"),
          const SizedBox(height: 8),
          Form(
            child: TextField(
                controller: textfieldsController,
                decoration: const InputDecoration(labelText: 'カテゴリー'),
                // 最大文字数
                maxLength: 10,
                onChanged: _handleText),
          ),
          const Spacer(
            flex: 1,
          ),
          Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: '重量or距離'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: '回数or時間'),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _textList.add(_text);
                _text = '';
                textfieldsController.clear();
              });
            },
            child: const Text('保存'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(_size.width * 0.7, _size.height * 0.05)),
          ),
          ElevatedButton(
            child: const Text(
              'ページ3へ',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(_size.width * 0.7, _size.height * 0.05),
              primary: Colors.orange,
            ),
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }
}

// （ページ2）右ページ
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'ページ2',
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

// ページ3（遷移するページ）
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ページ3"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('戻る'),
        ),
      ),
    );
  }
}
