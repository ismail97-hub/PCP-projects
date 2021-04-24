import 'dart:io';

import 'package:PCP/ImagesPage.dart';
import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
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
  ChewieController chewieController;

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
             Navigator.push(context, MaterialPageRoute(
              builder:  (context) => AudioPage(video: _path,)),
             ); 
          });
        });
        print(_controller);
        print(_path);
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
          )
        ],
      ),
      body: Container(
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
              margin: EdgeInsets.only(right:40,top: 25),
              width: 350,
              height: 300,
              child: Image.asset("assets/vdpng.png")
            ),  
            InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  width: 200.0,
                  height: 200.0,
                  color: Colors.black38,
                    child: DottedBorder(color: Colors.white,
                      radius: Radius.circular(10),
                      dashPattern: [6],
                        child: Center(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.video_call,size: 50,color: Colors.white,),
                              Text("Ajouter", style: TextStyle(color: Colors.white),),
                            ],
                        ),
                      ),
                    ),  
                ),
                onTap: (){
                  _showPhotocamera();
                },
              ),
          ],
        ),
      ),
    );
  }
}