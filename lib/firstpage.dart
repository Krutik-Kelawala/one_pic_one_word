import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:one_pic_one_word/secondpag.dart';

class firstpg extends StatefulWidget {
  @override
  State<firstpg> createState() => _firstpgState();
}

class _firstpgState extends State<firstpg> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioplay();
  }

  audioplay() async {
    String audioasset = "backgroundaudio/game-music-7408.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    player.playBytes(audiobytes);
  }

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double thestatusbarheight = MediaQuery.of(context).padding.top;
    double thenavigatorbarheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyheight = theheight - thestatusbarheight - thenavigatorbarheight;

    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: bodyheight * 0.4,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("backimg/oneword.png"))),
          ),
          Container(
            height: bodyheight * 0.2,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "one ",
                      style: TextStyle(
                          color: Colors.black, fontSize: bodyheight * 0.03)),
                  TextSpan(
                      text: "Pic ",
                      style: TextStyle(
                          color: Colors.purple, fontSize: bodyheight * 0.05)),
                  TextSpan(
                      text: "one ",
                      style: TextStyle(
                          color: Colors.black, fontSize: bodyheight * 0.03)),
                  TextSpan(
                      text: "Word\n",
                      style: TextStyle(
                          color: Colors.purple, fontSize: bodyheight * 0.05)),
                  TextSpan(
                      text: "Game",
                      style: TextStyle(
                          color: Colors.black, fontSize: bodyheight * 0.05))
                ])),
          ),
          Container(
            height: bodyheight * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FlatButton(
                    color: Colors.amberAccent,
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return mainpage();
                        },
                      ));
                    },
                    child: Text("Start"),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Colors.amberAccent,
                    onPressed: () {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ClassicGeneralDialogWidget(
                            titleText: 'Exit',
                            contentText: 'Are you sure exit the game?',
                            onPositiveClick: () {
                              Navigator.of(context).pop();
                              SystemNavigator.pop();
                            },
                            onNegativeClick: () {
                              Navigator.of(context, rootNavigator: false).pop();
                            },
                          );
                        },
                        animationType: DialogTransitionType.fadeScale,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Text("Exit"),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
