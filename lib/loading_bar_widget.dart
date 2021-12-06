import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CircularProgressIndicator(),
    );
  }
}
