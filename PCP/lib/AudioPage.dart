import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

import 'SelectionerType.dart';

// import 'SelectionerType.dart';

class AudioPage extends StatefulWidget {
  final io.File file1;
  final io.File file2;
  final io.File file3;
  final io.File file4;
  final io.File file5;
  final io.File video;

  AudioPage({this.file1,this.file2,this.file3,this.file4,this.file5,this.video});
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String statusText = "";
  bool isComplete = false;
  bool playaudio = false;

  @override
  void initState() {
    super.initState();
    // handleTick()
  }

  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;
  bool disable = false;
  File file;
  Timer timer;

  void handleTick() {
    setState(() {
      secondsPassed = secondsPassed + 1;
      print(secondsPassed);
    });
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();

      isComplete = true;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  String a;

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        a = "resume";
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        a = "pause";
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isComplete = false;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;
  AudioPlayer audioPlayer = AudioPlayer();
  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      setState(() {
        if (playaudio == false) {
          playaudio = true;
        }
      });

      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    return Scaffold(
      appBar: AppBar(
        title: Text("CONTROLE PCP"),
        backgroundColor: HexColor("#f7931e"),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: () {
            file = File(recordFilePath);
            audioPlayer.pause();
            print(file);
            if (file == null) {
              Fluttertoast.showToast(
                  msg: "Prendre un audio svp !!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SelectionerType(widget.file1,widget.file2,widget.file3,widget.file4,widget.file5,file,widget.video),
                ),
              );

            }
          },
          backgroundColor: HexColor("#F7931E"),
          child: Center(
            child: Text(
              ">",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backaudio.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/back.png"),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(right: 5.0, left: 5.0, top: 5),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    LabelText(
                                        label: 'MIN',
                                        value:
                                            minutes.toString().padLeft(2, '0')),
                                    LabelText(
                                        label: 'SEC',
                                        value: ":" +
                                            seconds.toString().padLeft(2, '0')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 20),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 18),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      onPressed: () {
                                        stopRecord();
                                        timer.cancel();
                                        setState(() {
                                          disable = false;
                                        });
                                      },
                                      child: Image.asset("assets/pause.png"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      onPressed: () {
                                        if (disable == false) {
                                          setState(() {
                                            play();
                                            timer.cancel();
                                          });
                                        }
                                      },
                                      child: Image.asset("assets/play.png"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      onPressed: () {
                                        if (disable == true) {
                                          pauseRecord();
                                          if (a == "pause") {
                                            timer.cancel();
                                          } else {
                                            secondsPassed = secondsPassed;
                                            timer = Timer.periodic(duration,
                                                (Timer t) {
                                              handleTick();
                                            });
                                          }
                                        }
                                      },
                                      child: Image.asset("assets/stop.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          height: 150.0,
                          elevation: 10.0,
                          onPressed: () {
                            audioPlayer.pause();
                            if (disable == false) {
                              setState(() {
                                audioPlayer = AudioPlayer();
                                startRecord();
                                disable = true;
                                if (timer == null) {
                                  timer = Timer.periodic(duration, (Timer t) {
                                    handleTick();
                                  });
                                } else {
                                  secondsPassed = 0;
                                  timer = Timer.periodic(duration, (Timer t) {
                                    handleTick();
                                  });
                                }
                              });
                            }
                          },
                          color: isComplete ? Colors.white : Colors.black12,
                          textColor: isComplete ? Colors.black : Colors.white,
                          child: Icon(
                            Icons.mic_none_rounded,
                            size: 50,
                          ),
                          // padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value = null});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}