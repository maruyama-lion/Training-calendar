// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class AddPage extends StatefulWidget {
//   const AddPage({Key? key}) : super(key: key);

//   @override
//   _AddPageState createState() => _AddPageState();
// }

// class _AddPageState extends State<AddPage> {
class AddPage extends StatelessWidget {
  late CollectionReference reports;
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  final textController = TextEditingController();
  final categoryController = TextEditingController();

  Future<void> addReport() async {
    var collection = FirebaseFirestore.instance.collection('report');
    collection.add({
      'category': categoryController.text,
      // 'text': textController.text,
      'date': DateFormat('yyyy年M月d日').format(DateTime.now()),
      'created_date': DateTime.now(),
    });
  }

  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    categoryController.dispose();
    textController.dispose();
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ここは追加画面"),
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
              onPressed: () {
                addReport();
                categoryController.clear();
                textController.clear();
                Navigator.pop(context);
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
      ),
    );
  }
}
