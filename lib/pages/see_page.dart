// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeePage extends StatelessWidget {
  QueryDocumentSnapshot report;
  SeePage(this.report);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((report.data() as Map)['category']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'メモの内容',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text((report.data() as Map)['category'],
                style: const TextStyle(fontSize: 18)),
            Text((report.data() as Map)['date'],
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
