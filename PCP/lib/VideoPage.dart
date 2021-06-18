import 'dart:io';
import 'dart:ui';

import 'package:PCP/ImagesPage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'AudioPage.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  File _path;
  VideoPlayerController _controller;

  void _showPhotocamera() async {
    final myfile = await ImagePicker().getVideo(source: ImageSource.camera);
    if (myfile != null)
      setState(() {
        _path = File(myfile.path);
        _controller = VideoPlayerController.file(_path)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            // chewieController = ChewieController(
            //   videoPlayerController: _controller,
            //   autoPlay: true,
            //   looping: false,
            //   aspectRatio: _controller.value.aspectRatio,
            //   fullScreenByDefault: true 
              
            // );  
             Navigator.of(context).push(CupertinoPageRoute(
              builder:  (context) => AudioPage(video: _path,)),
             ); 
          });
        });
        print(_controller);
        print(_path);
      });
  }
  showdialog(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text("جاري وضع الاعلان ..."),
            content: Container(
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.grey),
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#ff931e"),
        title: Text("CONTROLE PCP"),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder:  (context) => ImagesPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgv.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:Column(
            children: [
             Container(
                margin: EdgeInsets.only(top:20.0,bottom: 10),
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/vdpng.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ), 
              Container(margin: EdgeInsets.only(bottom:20),child: Text("VIDEO",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),)),
              InkWell(
                  child: DottedBorder(
                    radius: Radius.circular(10),
                    dashPattern: [6],
                    color: Colors.black,
                    child: Container(
                      //margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/plusimagepcp.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    showdialog(context);
                    _showPhotocamera();
                  },
                ),
                Center(child: Container(margin: EdgeInsets.only(top:10,bottom: 10),width: 150,height: 50,child:Image.asset("assets/loadingVideo.png")))
            ],
          ),
        ),
      ),
    );
  }
}