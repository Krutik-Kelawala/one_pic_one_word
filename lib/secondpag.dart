import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'firstpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: firstpg(),
  ));
}

class mainpage extends StatefulWidget {
  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  Color wincolour = Colors.white54;
  List imagepathlist = [];
  String changeimage = "";
  List bottomlist = [];
  List toplist = [];
  List answerlist = [];
  String spelling = "";
  String abcd = "";
  List abcdlist = [];
  int cnt = 0; // for bottomlist return
  int abc = 0; // for top list return
  String imagepath = "";
  List cheklist = List.filled(10, "");
  bool winstage = false; //
  String winnig = "";

  // FlutterTts flutterTts = FlutterTts(); // for speech

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
      changeimage = imagepathlist[0];
      print(imagePaths);

      // for understanding

      // int a = Random().nextInt(imagepathlist.length);
      // imagepath = imagepathlist[a];
      // String imagepath = "Image/almond.webp";
      // print(imagepath);
      //
      // List<String> list1 = imagepath.split("/");//[Image, almond.webp]
      // print(list1);
      // String s1 = list1[1];//almond.webp
      // print(s1);
      // List<String> list2 = s1.split("\.");//[almond, webp]
      // print(list2);

      spelling = imagepathlist[0]
          .split("/")[1]
          .split("\.")[0]
          .toString()
          .toUpperCase(); //almond
      print("spel--$spelling");

      answerlist = spelling.split("");
      print("ans--$answerlist");

      toplist = List.filled(answerlist.length, "");

      print("top--$toplist");

      abcd = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      abcdlist = abcd.split(
          ""); //[a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
      abcdlist.shuffle();
      print("abcd--$abcdlist");

      bottomlist = abcdlist.getRange(0, 10 - answerlist.length).toList();
      print('bottom1--$bottomlist');

      bottomlist.addAll(answerlist);
      bottomlist.shuffle();
      print("btm--$bottomlist");
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Container(
                      height: bodyheight * 0.1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: answerlist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (toplist[index].toString().isNotEmpty) {
                                  abc = cheklist.indexOf(toplist[index]);
                                  bottomlist[abc] = toplist[index];
                                  toplist[index] = "";
                                  cnt--;
                                  print("aaa${cnt}");
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: wincolour,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              width: thewidth * 0.1,
                              margin: EdgeInsets.all(bodyheight * 0.01),
                              child: Center(
                                  child: Text("${toplist[index]}",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.04))),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: bodyheight * 0.4,
                margin: EdgeInsets.all(bodyheight * 0.01),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: bodyheight * 0.22,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (bottomlist[index].toString().isNotEmpty) {
                                  toplist[cnt] = bottomlist[index];
                                  cheklist[index] = bottomlist[index];
                                  // flutterTts
                                  //     .speak("${bottomlist[index].toString()}");
                                  bottomlist[index] = "";
                                  cnt++;
                                  win();
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(bodyheight * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                "${bottomlist[index]}",
                                style: TextStyle(fontSize: bodyheight * 0.04),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.05,
                      width: thewidth * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("${winnig}")),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: bodyheight * 0.05,
                            child: Icon(Icons.error_outline),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: bodyheight * 0.05,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                  ],
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
        Navigator.of(context, rootNavigator: false);
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

  void win() {
    if (toplist.toString() == answerlist.toString()) {
      setState(() {
        wincolour = Colors.green;
        winstage = true;
        winnig = "You are Win.!";
      });
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return mainpage();
        },
      ));
    }
    // else if(toplist.toString() == answerlist.toString()) {
    //   setState(() {
    //     wincolour = Colors.yellow;
    //   });
    // }
  }
}
