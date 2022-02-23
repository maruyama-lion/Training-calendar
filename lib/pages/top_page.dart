// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

// （ページ1）左ページ
class _TopPageState extends State<TopPage> {
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  final textController = TextEditingController();
  final categoryController = TextEditingController();

  Future<void> addReport() async {
    var collection = FirebaseFirestore.instance.collection('report');
    collection.add({
      'category': categoryController.text,
      // 'text': textController.text,
      // 'created_data': Timestamp.now(),
    });
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

    return Center(
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
            onPressed: () {
              setState(() {
                addReport();
                categoryController.clear();
                textController.clear();
              });
            },
            child: const Text('保存'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(_size.width * 0.8, _size.height * 0.05)),
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }
}
