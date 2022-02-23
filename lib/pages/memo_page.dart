// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_calendar/pages/edit_page.dart';
import 'package:training_calendar/pages/see_page.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late CollectionReference memos;

  Future<void> deleteMemo(String docId) async {
    var document = FirebaseFirestore.instance.collection('memo').doc(docId);
    await document.delete();
  }

  @override
  void initState() {
    super.initState();
    memos = FirebaseFirestore.instance.collection('memo');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: memos.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        (snapshot.data!.docs[index].data() as Map)['text']),
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
                                                    memo: snapshot
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
                                        await deleteMemo(
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
