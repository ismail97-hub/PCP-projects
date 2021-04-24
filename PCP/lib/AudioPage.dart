import 'dart:io' as io;
import 'dart:math';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'SelectionerType.dart';

class AudioPage extends StatefulWidget {
  final io.File file1;
  final io.File file2;
  final io.File file3;
  final io.File file4;
  final io.File file5; 
  final io.File video;
  final LocalFileSystem localFileSystem;

  AudioPage({localFileSystem,this.file1,this.file2,this.file3,this.file4,this.file5,this.video})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
 Recording _recording = new Recording();
  bool _isRecording = false;
  Random random = new Random();
  TextEditingController _controller = new TextEditingController();
  bool _isPlaying = false;
  AudioPlayer audioPlayer;
  String pathaudio;
  var tr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
  }

  bienenregestrer() {
    Fluttertoast.showToast(
        msg: "audio bien enregistrée",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  deleteaudio(String path) {
    final dir = io.Directory(path);
    dir.deleteSync(recursive: true);
  }

  playAudioFromLocalStorage(path) async {
    int response = await audioPlayer.play(path, isLocal: true);
    if (response == 1) {
      // success

    } else {
      print('Some error occured in playing from storage!');
    }
  }

  pauseAudio() async {
    int response = await audioPlayer.pause();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in pausing');
    }
  } 

  stopAudio() async {
    int response = await audioPlayer.stop();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in stopping');
    }
  }

  resumeAudio() async {
    int response = await audioPlayer.resume();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in resuming');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONTROLE PCP"),
        backgroundColor: HexColor("#fe7600"),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                right: 5.0, bottom: 2, top: 10, left: 5.0),
                            child: Text(
                              "Enregistrez l'audio",
                              style: TextStyle(
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: HexColor("#fe7600"),
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //     color: Colors.orangeAccent, width: 2)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      elevation: 10.0,
                                      onPressed: () {
                                        if (_isRecording) {
                                          _stop();
                                          bienenregestrer();
                                        }
                                      },
                                      // onPressed(){
                                      //   _stop;
                                      // },
                                      color: Colors.black38,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.stop,
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      elevation: 10.0,
                                      onPressed: () {
                                        if (text != null) {
                                          playAudioFromLocalStorage(text);
                                        }
                                      },
                                      color: Colors.black38,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: 50.0,
                                      elevation: 10.0,
                                      onPressed: () {
                                        Recording _recording = new Recording();
                                        // text = null;
                                        try {
                                          if (text != null) {
                                            _start();
                                            deleteaudio(text);
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      // onPressed: _isRecording ? null : _start,
                                      color: Colors.black38,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.replay,
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      shape: CircleBorder(),
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
                          onPressed: _isRecording ? null : _start,
                          color: Colors.black38,
                          textColor: Colors.white,
                          child: Icon(
                            Icons.mic_none_rounded,
                            size: 50,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
                width: double.infinity,
                height: 50.0,
                child: RaisedButton.icon(
                  onPressed: () {
                    if(file==null){
                      Fluttertoast.showToast(
                        msg: "Prendre un audio svp !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);  
                    }
                    else{
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionerType(widget.file1,widget.file2,widget.file3,widget.file4,widget.file5,file,widget.video),
                      ),
                    );
                    }
                    
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  label: Text(
                    'Suivant',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  // color: HexColor("#318aff"),//blue
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _start() async {
    print("cccccc");
    try {
      if (await AudioRecorder.hasPermissions) {
        if (text != null && text != "") {
          String path = text;
          pathaudio = _recording.path;
          if (!text.contains('/')) {
            io.Directory appDocDirectory =
                await getApplicationDocumentsDirectory();
            path = appDocDirectory.path + '/' + text;
          }
          print("Start recording: $path");
          await AudioRecorder.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          await AudioRecorder.start();
        }
        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          _recording = new Recording(duration: new Duration(), path: "");
          _isRecording = isRecording;
          print("_isRecording");
          print(_isRecording);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }
  File file;
  String text;
  _stop() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    file = widget.localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    text = recording.path;
  }
}