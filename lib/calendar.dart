import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nav_sempai_backend.dart' as nav;

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      title: 'Calendar',
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  //CalendarFormat _calendarFormat = CalendarFormat.month;

  bool isLoading = false;

  Future<List> ButtonPressed() async {
    var myList = await nav.loadData(savedDate: _selectedDay!);
    print("===$myList");
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calendar"),
          backgroundColor: const Color(0xFF6c848d),
        ),
        body: Container(
            color: const Color(0xFFefefef),
            child: Column(children: [
              TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color(0xFF418b89), shape: BoxShape.circle)),
                  focusedDay: _focusedDay,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      isLoading = true;
                    });

                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });

                      // Map<String, dynamic> myJson = {
                      //   'savedDate': _selectedDay.toString(),
                      //   "savedMemo": "Memo from calander",
                      // };

                      // nav.saveData(
                      //     savedDate: _selectedDay!,
                      //     savedMemo: "Its another day ");

                      // if (_selectedDay.toString() ==
                      //     "2021-12-06 00:00:00.000Z") {
                      //   nav.saveData(
                      //       savedDate: _selectedDay!,
                      //       savedMemo: "Its the 6th ");
                      // }

                      Get.toNamed("/report", arguments: [_selectedDay]);
                      // Future.delayed(const Duration(milliseconds: 500), () {
                      //   setState(() {});
                      // });
                    } else {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });

                      print("THIS IS TRIGGER");
                      // nav.saveData(
                      //     savedDate: _focusedDay,
                      //     savedMemo: "Pressed on current day");
                      Get.toNamed("/report", arguments: [_focusedDay]);
                    }
                  }),

              // Center(
              //     child: isLoading == true
              //         ? const CircularProgressIndicator()
              //         : Container()),

              // CircularProgressIndicator(),

              // TextButton(
              //   child: Text("1ページ目に遷移する"),
              //   onPressed: (){
              //     // （1） 指定した画面に遷移する
              //     Navigator.push(context, MaterialPageRoute(
              //       // （2） 実際に表示するページ(ウィジェット)を指定する
              //         builder: (context) => ReportPage()
              //     ));
              //   },
              // ),
            ])));
  }
}
