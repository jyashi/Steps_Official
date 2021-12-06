import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";
import 'package:ver1_20210924/nav_image_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'diary_data.dart';
import 'nav_sempai_backend.dart' as nav;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? json = prefs.getString("TestUser_Key");
  //   print("Loaded Json $json");

  //   if (json == null) {
  //     print("No data found in prefs");
  //   } else {
  //     Map<String, dynamic> map = jsonDecode(json);
  //     print("map: $map");
  //     var diaryData = DiaryData.fromJson(map);
  //     print("Saved Date: ${diaryData.savedDate},${diaryData.savedMemo}");
  //   }
  // }

// ,${diaryData.savedMemo}

  // saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   final myDiaryData = DiaryData(
  //     savedDate: DateTime.now().toString(),
  //     savedMemo: "Test Memo",
  //   );
  //   String json = jsonEncode(myDiaryData);

  //   print("Saved Json $json");
  //   prefs.setString("TestUser_Key", json);
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Save Data to JSon")),
          ElevatedButton(
              onPressed: () {
                // loadData();
                // nav.loadData(savedDate: Datetime.now());
              },
              child: Text("Load Data from JSon")),
        ],
      ),
    );
  }
}
