import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";
import 'package:ver1_20210924/nav_image_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ver1_20210924/nav_sempai_backend.dart';

// To access this date from other classes.
getDate() {
  var date = [
    DateTime.now(),
    "",
  ];
  date[0] = Get.arguments;

  return date[0];
}

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List TodayTopics = [];
  List MyTrend = [];

  _readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/TodayNews.json")
        .then((s) {
      setState(() {
        TodayTopics = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/MyTrend.json")
        .then((s) {
      setState(() {
        MyTrend = json.decode(s);
      });
    });
  }

  String editText = "";
  final _textController = TextEditingController();
  @override
  void initState() {
    _readData();
    super.initState();

    _textController.addListener(() {
      editText;
    });
  }

  String waitForData() {
    while (one[1] == null) {}
    return one[1];
  }

  var one = Get.arguments;

  Future<String> myMemo() async {
    var myString;
    myString = await loadData(savedDate: one[0]);

    return myString[1];
  }

  void refreshFuture() {
    setState(() {
      myMemo();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Color(0xFFbd6856),
        // ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 50),
                color: const Color(0xFFefefef),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        DateFormat('yyyy年 M月 d日').format(one[0]),
                        style: const TextStyle(
                          color: Color(0xFF555647),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Insert image box
                    NavImageBox(),
                    const Divider(
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          //Memo part

                          Text(
                            "Enter Memo",
                            style: const TextStyle(
                                color: Color(0xFF1f2326),
                                fontSize: 20,
                                decoration: TextDecoration.none),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            "Detail",
                            style: TextStyle(
                                color: Color(0xFFffa07a),
                                fontSize: 15,
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFffa07a)),
                            child: GestureDetector(
                                child: const Icon(Icons.arrow_forward_ios,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),

                      // Editable Text field
                      child: FutureBuilder(
                        future: myMemo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print("Returning text value");
                            // Future.delayed(const Duration(seconds: 2), () {
                            //   print("Value after future was ${myData()}");

                            // });
                            // return CircularProgressIndicator();
                            // return Text("${snapshot.data}");
                          }
                          editText = snapshot.data.toString();
                          return Stack(children: [
                            Text(editText),

                            // TextButton(
                            //     style:
                            //         ButtonStyle(alignment: Alignment.topRight),
                            //     onPressed: () {
                            //       print("Text button called");
                            //       print("The Edit Text property is: $editText");
                            //       setState(() {
                            //         editText = "Yohohoh";
                            //       });
                            //     },
                            //     child: Text("Press here")),
                            //----------------------
                            TextButton(
                                onPressed: () {
                                  _textController.text = editText;

                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: Text("Enter Memo"),
                                              content: TextField(
                                                restorationId: editText,
                                                // onChanged: (value) =>
                                                //     setState(() {
                                                //   print("Updated edit text");
                                                //   editText = _textController.text;
                                                // }),
                                                controller: _textController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      navigator!.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      saveData(
                                                          savedDate: one[0],
                                                          savedMemo:
                                                              _textController
                                                                  .text);
                                                      setState(() {
                                                        myMemo();
                                                        print(
                                                            "MyMemo refreshing...");
                                                      });
                                                      navigator!.pop(context);
                                                    },
                                                    child: Text("Submit")),
                                              ]
                                              // navigator.of(context).pop(_textController.text)],
                                              ));
                                },
                                child: Text(""))
                          ]);
                          // return Text(editText);
                          // return Text("${snapshot.data}");

                          // else {
                          //   return CircularProgressIndicator();
                          // }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("Delete"),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "よく使った言葉",
                        style: TextStyle(
                            color: Color(0xFF1f2326),
                            fontSize: 20,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //list
                    SizedBox(
                        height: 180,
                        width: width,
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: MyTrend.length,
                                itemBuilder: (_, i) {
                                  return Container(
                                    width: width,
                                    height: 60,
                                    margin: const EdgeInsets.only(
                                        left: 25, right: 20, bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFdcd6d2),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        MyTrend[i]['title'],
                                        style: const TextStyle(
                                            color: Color(0xFF1f2326),
                                            fontSize: 18,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  );
                                }))),
                    // _VerticalList(context, MyTrend, width, Color(0xFFe6bfb2), Color(0xFFe8d3ca)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          const Text(
                            "今日のニュース",
                            style: TextStyle(
                                color: Color(0xFF1f2326),
                                fontSize: 20,
                                decoration: TextDecoration.none),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            "Detail",
                            style: TextStyle(
                                color: Color(0xFFffa07a),
                                fontSize: 15,
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFffa07a)),
                            child: GestureDetector(
                                child: const Icon(Icons.arrow_forward_ios,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //list
                    _VerticalList(context, TodayTopics, width,
                        const Color(0xFF8fbc8f), const Color(0xFF54917f)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(children: [
                          const Text(
                            "ヘルスケア",
                            style: TextStyle(
                                color: Color(0xFF1f2326),
                                fontSize: 20,
                                decoration: TextDecoration.none),
                          ),
                          Expanded(child: Container()),
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        height: 100,
                        width: width,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage("img/5.jpg"),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "歩数",
                                    style: TextStyle(
                                        color: Color(0xFF3b3f42),
                                        fontSize: 18,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Number of steps",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.none),
                                  ),
                                ]),
                            const SizedBox(
                              width: 30,
                            ),
                            const Text(
                              "121",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        height: 100,
                        width: width,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset("img/6.png"),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "移動距離",
                                    style: TextStyle(
                                        color: Color(0xFF3b3f42),
                                        fontSize: 18,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Moving distance",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.none),
                                  ),
                                ]),
                            const SizedBox(
                              width: 30,
                            ),
                            const Text(
                              "2021 km",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))));
  }
}

Widget _VerticalList(
    BuildContext context, List list, double width, Color color1, Color color2) {
  return SizedBox(
      height: 320,
      child: PageView.builder(
          controller: PageController(viewportFraction: 0.88),
          itemCount: list.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: 320,
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: i.isEven ? color1 : color2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          list[i]['title'],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: Text(
                        list[i]['text'],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 1.0,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                image: AssetImage(list[i]['img']),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }));
}
