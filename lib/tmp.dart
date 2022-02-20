// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // このウィジェットは、あなたのアプリケーションのルートです。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // これは、アプリケーションのテーマです。
        //
        // アプリケーションを「flutter run」で実行してみてください。
        // アプリケーションのツールバーが青くなっているのがわかると思います。
        // 次に、アプリケーションを終了せずに、以下のprimarySwatchをColors.greenに変更してから、
        // 以下のコマンドを実行してみてください。
        // "hot reload"（"flutter run "を実行したコンソールで "r "を押してください。
        // または、Flutter IDEで変更を保存して "hot reload "を実行します）。)
        // カウンターがゼロに戻っていないことに注意してください。
        // アプリケーションは再起動されていません。
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '筋トレアプリ Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // このウィジェットは，アプリケーションのホーム・ページです。
  // ステートフルとは、表示方法に影響を与えるフィールドを含むStateオブジェクト（以下に定義）を持つことを意味します。

  // このクラスは、ステートの設定です。
  // 親(ここではAppウィジェット)から提供され、Stateのbuildメソッドで使用される値(ここではタイトル)を保持します。
  // Widgetサブクラスのフィールドは、常に "final "と表示されます。

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  get home => null;

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
    // このメソッドは、setStateが呼ばれるたびに再実行されます。
    // 例えば、上記の_incrementCounterメソッドで行われます。
    //
    // Flutterフレームワークは、ビルドメソッドの再実行を高速化するように最適化されており、
    // ウィジェットのインスタンスを個別に変更するのではなく、更新が必要なものをすべてリビルドできるようになっています。
    var _size = MediaQuery.of(context).size;

    void _handleText(String e) {
      print("call _handleText");
      print("_text = ${_text}");
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

    return Scaffold(
        appBar: AppBar(
          // ここでは、App.buildメソッドで作成されたMyHomePageオブジェクトから値を取得し、
          // それを使ってアプリバーのタイトルを設定しています。
          title: Text(widget.title),
        ),
        body: Center(
          // Centerは、レイアウトウィジェットです。
          // Single childを受け取り、親の中央に配置します。
          child: Column(
            // Columnは、レイアウトウィジェットでもあります。
            // 子のリストを受け取り、それらを垂直に並べます。
            // デフォルトでは、子の水平方向に合わせてサイズを調整し、親と同じ高さになるようにします。
            //

            // 「デバッグペイント」を呼び出すと
            //　（コンソールで「p」を押すか、Android StudioのFlutterインスペクタで「デバッグペイントを切り替える」アクションを選択するか、
            //　Visual Studio Codeで「デバッグペイントを切り替える」コマンドを実行する）、各ウィジェットのワイヤフレームが表示されます。
            // このsetStateの呼び出しは、Flutterフレームワークに、このStateに何か変更があったことを伝え、
            // 以下のビルドメソッドを再実行させ、更新された値を表示に反映させます。setState()を呼び出さずに_counterを変更した場合、
            // ビルドメソッドは再び呼び出されないので、何も起こらないように見えます。

            //
            // Columnには、自身のサイズや子の配置を制御する様々なプロパティがあります。
            // ここでは、mainAxisAlignmentを使用して、子を垂直方向に中央に配置しています。
            // Columnは垂直方向に配置されるので、ここでの主な軸は垂直軸です（交差軸は水平方向になります）。
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              Text("_text = ${_textList}"),
              Text("_text = ${_text}"),
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
                    textfieldsController.clear();
                  });
                },
                child: const Text('保存'),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(_size.width * 0.7, _size.height * 0.05)),
              ),
              const Spacer(
                flex: 6,
              ),
              // Row(
              //   children: const <Widget>[
              //     Text('aaa'),
              //     Text('bbb'),
              //   ],
              // ),
              // const Spacer(
              //   flex: 3,
              // ),
            ],
          ),
        ),
        // このウィジェットはフッター
        bottomNavigationBar: const Footer()
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // この末尾のコンマは、ビルドメソッドの自動フォーマットをより良いものにします。
        );
  }
}
