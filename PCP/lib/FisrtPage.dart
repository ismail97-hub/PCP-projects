import 'package:PCP/ImagesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  checkLocationCamrea() async{
    var microStatus = await Permission.microphone.status;
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;
    print(microStatus);
    print(cameraStatus);
    print(storageStatus);
    if(!microStatus.isGranted){
      await Permission.microphone.request();
    }
    if(!cameraStatus.isGranted){
      await Permission.camera.request();
    }
    if(!storageStatus.isGranted){
      await Permission.storage.request();
    } 
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationCamrea();
  }
  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage('assets/AddVideo.png'),context); 
    // precacheImage(AssetImage('assets/back.png'),context);
    // precacheImage(AssetImage('assets/backaudio.png'),context);
    // precacheImage(AssetImage('assets/backdesc.png'),context);
    precacheImage(AssetImage('assets/backfirst.png'),context);
    // precacheImage(AssetImage('assets/background.jpg'),context);
    // precacheImage(AssetImage('assets/backimagepcp.png'),context);
    // precacheImage(AssetImage('assets/backsimpledesc.png'),context);
    // precacheImage(AssetImage('assets/bgST.png'),context);
    // precacheImage(AssetImage('assets/bgv.png'),context);
    // precacheImage(AssetImage('assets/empty1.jpg'),context);
    // precacheImage(AssetImage('assets/imageempty.png'),context);
    // precacheImage(AssetImage('assets/imagesimple2.png'),context);
    // precacheImage(AssetImage('assets/loadingVideo.png'),context);
    // precacheImage(AssetImage('assets/logoPCP.png'),context);
    // precacheImage(AssetImage('assets/pause.png'),context);
    // precacheImage(AssetImage('assets/play.png'),context);
    // precacheImage(AssetImage('assets/plusimagepcp.png'),context);
    // precacheImage(AssetImage('assets/stop.png'),context);
    // precacheImage(AssetImage('assets/STpng.png'),context);
    // precacheImage(AssetImage('assets/vdpng.png'),context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backfirst.png"),
            fit: BoxFit.cover,
          ),
        )
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ImagesPage()));
          },
          backgroundColor: HexColor("#F7931E"),
          child: Center(child: Text(">", style: TextStyle(color: Colors.white, fontSize: 30.0),),),
        ),
      ),
    );
  }
}