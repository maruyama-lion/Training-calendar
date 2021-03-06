// ignore_for_file: avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  late final QueryDocumentSnapshot report;
  EditPage({required this.report});

  @override
  _EditPageState createState() => _EditPageState();
}

// （ページ1）左ページ
class _EditPageState extends State<EditPage> {
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  final textController = TextEditingController();
  final categoryController = TextEditingController();

  Future<void> updateReport() async {
    var document =
        FirebaseFirestore.instance.collection('report').doc(widget.report.id);
    await document.update({
      'category': categoryController.text,
      // 'text': textController.text,
      // 'created_data': Timestamp.now(),
    });
  }

  @override
  void initState() {
    super.initState();
    categoryController.text = (widget.report.data() as Map)['category'];
    // textController.text = (widget.report.data() as Map)['text'];
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    categoryController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text((widget.report.data() as Map)['category']),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: 'カテゴリー'),
                    // 最大文字数
                    maxLength: 10),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(labelText: 'text'),
                    // 最大文字数
                    maxLength: 10),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: '重量or距離'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
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
                onPressed: () async {
                  await updateReport();
                  Navigator.pop(context);
                },
                child: const Text('保存'),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(_size.width * 0.8, _size.height * 0.05)),
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
                      builder: (context) => const NewPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(_size.width * 0.8, _size.height * 0.05),
                  primary: Colors.orange,
                ),
              ),
              const Spacer(
                flex: 6,
              ),
            ],
          ),
        ));
  }
}

// ページ3（遷移するページ）
class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ページ3"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('戻る'),
        ),
      ),
    );
  }
}
