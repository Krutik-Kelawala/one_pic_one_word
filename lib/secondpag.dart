import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firstpage.dart';

void main() {
  runApp(MaterialApp(
    home: firstpg(),
  ));
}

class mainpage extends StatefulWidget {
  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  List imagepathlist = [];
  String changeimage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initImages();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('Image/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      imagepathlist = imagePaths;
      imagepathlist.shuffle();
      changeimage = imagepathlist[1];
      print(imagePaths);

      // for understanding

      // int a = Random().nextInt(imagepathlist.length);
      // String imagepath = imagepathlist[a];
      String imagepath = "Image/almond.webp";
      // print(imagepath);
      //
      // List<String> list1 = imagepath.split("/");//[Image, almond.webp]
      // print(list1);
      // String s1 = list1[1];//almond.webp
      // print(s1);
      // List<String> list2 = s1.split("\.");//[almond, webp]
      // print(list2);

      String spelling = imagepath.split("/")[1].split("\.")[0]; //almond
      print(spelling);

      List answerlist = spelling.split("");
      print(answerlist);

      List tooltips = List.filled(answerlist.length, "");
      print(tooltips);

      String abcd = "abcdefghijklmnopqrstuvwxyz";
      List abcdlist = abcd.split(
          ""); //[a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
      abcdlist.shuffle();
      print(abcdlist);

      List bottomlist = abcdlist.getRange(0, 10 - answerlist.length).toList();
      print(bottomlist);

      bottomlist.addAll(answerlist);
      bottomlist.shuffle();
      print(bottomlist);
    });
  }
  String a = "";

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double thestatusbarheight = MediaQuery.of(context).padding.top;
    double thenavigatorbarheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyheight = theheight - thestatusbarheight - thenavigatorbarheight;

    return WillPopScope(
      onWillPop: onback,
      child: Scaffold(
        backgroundColor: Colors.tealAccent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: bodyheight * 0.5,
                margin: EdgeInsets.all(bodyheight * 0.01),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green,
                          offset: Offset(2, 2),
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent),
                child: Column(
                  children: [
                    Container(
                      height: bodyheight * 0.3,
                      width: thewidth * 0.5,
                      alignment: AlignmentDirectional.topCenter,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      margin: EdgeInsets.all(bodyheight * 0.01),
                      child: Center(child: Image.asset("${changeimage}")),
                    ),
                  ],
                ),
              ),
              Container(
                height: bodyheight * 0.4,
                margin: EdgeInsets.all(bodyheight * 0.01),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  // child: Inputbutton(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onback() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'EXIT',
      desc: 'Are you sure exit the game?',
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkOnPress: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return firstpg();
          },
        ));
      },
    )..show();
    return Future.value(true);
  }

  List<Widget> Inputbutton() {
    List<Widget> temp = [];
    for (int i = 0; i < 10; i++) {
      temp.add(Container(
        child: Center(
          child: Text(
            "${i}",
            style: TextStyle(color: Colors.black, fontSize: 20,),
          ),
        ),
      ));
    }
    return temp;
  }
}
