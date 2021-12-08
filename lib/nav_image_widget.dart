import 'package:flutter/widgets.dart';
// import 'package:flutter_application_1/nav_sempai_backend.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ver1_20210924/nav_sempai_backend.dart';
import 'calendar.dart';
import 'report.dart';
// import 'home_page.dart';

/*
TO DO:
- Size box to contain image with
- Saving the image appropriately so it is loaded on restart
- Arrays or Maps to use class in different instances
*/

class NavImageBox extends StatefulWidget {
  const NavImageBox({Key? key}) : super(key: key);

  @override
  _NavImageBoxState createState() => _NavImageBoxState();
}

XFile? img;
XFile? imageFile;

Future<String> getGalleryImage() async {
  img = await ImagePicker().pickImage(source: ImageSource.gallery);
  var imgPath = img!.path;
  if (img == null) return "";
  return imgPath;
}

class _NavImageBoxState extends State<NavImageBox> {
  navTakePicture() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    String imagePath = img
            ?.path ?? // This ?? operator is important as a backup in case value was null
        "/data/user/0/com.example.flutter_application_1/app_flutter/image1.jpg";
    // final File imageStored = await File(imagePath).copy(dir + "/image1.jpg");

    // bodyText = dir + "/image1.jpg";

    // bodyText = imageStored.path;
    setState(() {
      // imageStored;
      // imageStored;
      imageFile = img;
      // print("|||||");
      // print(imageFile?.path.toString());
    });
  }

  navPickPicture() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // preferredCameraDevice: CameraDevice.front,
    );
    String imagePath = img
            ?.path ?? // This ?? operator is important as a backup in case value was null
        "/data/user/0/com.example.flutter_application_1/app_flutter/image1.jpg";

    // final File imageStored = await File(imagePath).copy(dir + "/image1.jpg");

    // bodyText = dir + "/image1.jpg";

    // bodyText = imageStored.path;
    setState(() {
      // imageStored;
      // imageStored;
      imageFile = img;
      // print("|||||");
      // print(imageFile?.path.toString());
    });

    return img;
  }

  Widget navShowPic({String? futurePath}) {
    if (futurePath != null) {
      print("navi");
      String _path = futurePath;
      return Image.file(
        File(_path),
        width: 350,
        height: 350,
        fit: BoxFit.contain,
      );
    } else {
      if (imageFile != null) {
        String _path = imageFile!.path;
        saveData(savedDate: getDate(), savedPath: _path);
        return Image.file(
          File(_path),
          width: 350,
          height: 350,
          fit: BoxFit.contain,
        );
      } else {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Icon(Icons.error_sharp),
        );
      }
    }
  }

  Future<void> navShowDialogue(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      navPickPicture();
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      navTakePicture();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String> myPath() async {
    var myPath = await loadData(savedDate: DateTime.now());
    return myPath[2];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder(
          future: myPath(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {}

            return navShowPic();
          }),
      // navShowPic(),

      SizedBox(
        width: 300,
        height: 400,
        child: TextButton(
          onPressed: () {
            // getGalleryImage();
            // navTakePicture();
            navShowDialogue(context);
          },
          child: Container(),
        ),
      ),

      // Card(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(75.0),
      //     child: Image.asset(
      //       "assets/me.JPEG",
      //       width: 350,
      //       height: 350,
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      // ),
    ]);
  }
}
