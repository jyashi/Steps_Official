import 'package:flutter/material.dart';
import 'package:ver1_20210924/calendar.dart';
import 'package:ver1_20210924/report.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp()
      // new MaterialApp(
      //   home:CalendarPage(),
      // )
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => CalendarPage()),
        GetPage(name: "/report", page: () => ReportPage())
      ],
    );
  }
}
