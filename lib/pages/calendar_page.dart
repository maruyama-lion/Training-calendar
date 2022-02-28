// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_print

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

// （ページ2）右ページ
class _CalenderPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List> _eventsList = {};

  final Map<DateTime, List> _newevents = {
    DateTime.now().add(Duration(days: 22)): ['Event test']
  };

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Positioned(
      right: 5,
      bottom: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[300],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //サンプルのイベントリスト
    _eventsList = {
      DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      DateTime.now().add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      DateTime.now().add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      DateTime.now().add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
      DateTime.now().add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
      DateTime.now().add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEventForDay(DateTime day) {
      print("call getEventForDay ${_events}");
      return _events[day] ?? [];
    }

    return Center(
      child: Column(
        children: [
          TableCalendar(
              // 日本語化
              locale: 'ja_JP',

              // カレンダーの有効範囲
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),

              // 選択されている日付
              focusedDay: _focusedDay,
              eventLoader: getEventForDay,

              // カレンダーのフォーマット指定
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });

                  getEventForDay(_selectedDay!); //追記部分
                }
              },

              // 日付の選択でマーキング
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              // 日付の選択イベント
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },

              //TableCalendar内
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return _buildEventsMarker(date, events);
                  }
                },
              )),
          //以下追記
          ListView(
            shrinkWrap: true,
            children: getEventForDay(_selectedDay!)
                .map((event) => ListTile(
                      title: Text(event.toString()),
                    ))
                .toList(),
          ),
          TextButton(
            child: const Text('add'),
            onPressed: () {
              setState(() {
                // ignore: non_constant_identifier_names, unused_local_variable
                _eventsList.addAll(_newevents);
                print("call TextButton addAll _events $_events");
              });
            },
          )
        ],
      ),
    );
  }
}
