// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_calendar/pages/top_page.dart';
import 'package:training_calendar/pages/report_page.dart';

// カレンダーのためのimport
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

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
    const Page2(),
    // ページ3の画面
    const ReportPage(),
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

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

// （ページ2）右ページ
class _Page2State extends State<Page2> {
  final DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);
  // List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 2, 10): [
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        DateTime(2019, 2, 25),
        Event(
          date: DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        DateTime(2019, 2, 10),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(DateTime(2019, 2, 11), [
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    // ! _calendarCarousel　なんかよくわからんヘッダーがあるけど一旦コメント
    // final _calendarCarousel = CalendarCarousel<Event>(
    //   onDayPressed: (date, events) {
    //     setState(() => _currentDate = date);
    //     events.forEach((event) => print(event.title));
    //   },
    //   weekendTextStyle: const TextStyle(
    //     color: Colors.red,
    //   ),
    //   thisMonthDayBorderColor: Colors.grey,
    //   // weekDays: null, /// for pass null when you do not want to render weekDays
    //   headerText: 'Custom Header',
    //   weekFormat: true,
    //   markedDatesMap: _markedDateMap,
    //   height: 130.0,
    //   selectedDateTime: _currentDate2,
    //   showIconBehindDayText: true,
    //   // daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
    //   customGridViewPhysics: const NeverScrollableScrollPhysics(),
    //   markedDateShowIcon: true,
    //   markedDateIconMaxShown: 2,
    //   selectedDayTextStyle: const TextStyle(
    //     color: Colors.yellow,
    //   ),
    //   todayTextStyle: const TextStyle(
    //     color: Colors.blue,
    //   ),
    //   markedDateIconBuilder: (event) {
    //     return event.icon ?? const Icon(Icons.help_outline);
    //   },
    //   minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
    //   maxSelectedDate: _currentDate.add(const Duration(days: 360)),
    //   todayButtonColor: Colors.transparent,
    //   todayBorderColor: Colors.green,
    //   markedDateMoreShowTotal:
    //       true, // null for not showing hidden events indicator
    //   // markedDateIconMargin: 9,
    //   // markedDateIconOffset: 3,
    // );

    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //custom icon
          // ! _calendarCarousel　なんかよくわからんヘッダーがあるけど一旦コメント
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: _calendarCarousel,
          // ), // This trailing comma makes auto-formatting nicer for build methods.
          //custom icon without header
          Container(
            margin: const EdgeInsets.only(
              top: 30.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  _currentMonth,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                )),
                TextButton(
                  child: const Text('PREV'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
                TextButton(
                  child: const Text('NEXT'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader,
          ), //
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ページ3',
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ページ4',
    );
  }
}
