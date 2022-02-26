// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors

// import 'dart:html';

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_calendar/pages/add_page.dart';
import 'package:training_calendar/pages/edit_page.dart';
import 'package:training_calendar/pages/see_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late CollectionReference reports;

  Future<void> deleteReport(String docId) async {
    var document = FirebaseFirestore.instance.collection('report').doc(docId);
    await document.delete();
  }

  @override
  void initState() {
    super.initState();
    reports = FirebaseFirestore.instance.collection('report');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: reports.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('登録されてる記録はありません。'),
                    ElevatedButton(
                      child: Text('report追加'),
                      onPressed: () {
                        // 押したら反応するコードを書く
                        // 画面遷移のコード
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPage(),
                            ));
                      },
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        (snapshot.data!.docs[index].data() as Map)['category']),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                      ),
                                      title: Text('編集'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => EditPage(
                                                    report: snapshot
                                                        .data!.docs[index]))));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      title: Text('削除'),
                                      onTap: () async {
                                        await deleteReport(
                                            snapshot.data!.docs[index].id);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    onTap: () {
                      // 確認画面に遷移
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SeePage(snapshot.data!.docs[index])));
                    },
                  );
                },
              );
            }));
  }
}
