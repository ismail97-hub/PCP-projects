import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:PCP/FisrtPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FinalPage extends StatefulWidget {
  final File file1;
  final File file2;
  final File file3;
  final File file4;
  final File file5;
  final File audio; 
  final File video;
  final List<int> types;
  FinalPage(this.file1,this.file2,this.file3,this.file4,this.file5,this.audio,this.video,this.types);
  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  
  String description;
  TextEditingController descriptionController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.file1);
    print(widget.file2);
    print(widget.file3);
    print(widget.file4);
    print(widget.file5);
    print(widget.audio);
    print(widget.video);
    print(widget.types);
  }
  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      print("Error here !!!! ");
    } else {
      form.save();
      // print(description);
      // showdialog(context);
      // Timer(Duration(seconds: 3), () {
      //   Navigator.of(context).pop();
      //   Fluttertoast.showToast(
      //                   msg: "bien enregistré !!!",
      //                   toastLength: Toast.LENGTH_SHORT,
      //                   gravity: ToastGravity.BOTTOM,
      //                   timeInSecForIosWeb: 1,
      //                   backgroundColor: Colors.red,
      //                   textColor: Colors.white,
      //                   fontSize: 16.0);
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => FirstPage()),
      //     (Route<dynamic> route) => false,
      //   );
      // });
       upload();
    }
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
                  // Text("التحقق من صحة المعلومات"),
                  Center(child: Text("Enregistrement en cours ......")),
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
  String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  Future<http.Response> sendnotif() {
    String bodyy = json.encode({
      "subject": "Panne",
      "content": "Une nouvelle panne est declarée",
      "image":
          "https://www.michiganradio.org/sites/michigan/files/styles/medium/public/202003/hanson-lu-sq5P00L7lXc-unsplash.jpg",
      "data": {
        "key1": "heelo",
        "key2": "salam",
        "key3": "kirak",
        "key4": "Value 4"
      }
    });
    print("body****");
    print(bodyy);

    return http.post(
        'http://192.168.1.59:8060//send-notification',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyy);
  }
  Future upload() async {
    String url= "http://192.168.1.59:8060/Panne/";
    for (var i = 0; i < widget.types.length; i++) {
      if(i==0){
        url+=widget.types[i].toString(); 
      }
      else{
        url+=","+widget.types[i].toString();
      }
    }
    print(url);
    var request = http.MultipartRequest(
        "POST", Uri.parse(url));
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    request.headers["Content-Type"] = 'multipart/form-data';
    request.files.add(
      http.MultipartFile.fromBytes(
        'panne',
        utf8.encode(json.encode(<String, String>{
          "description": descriptionController.text,
          "date": formattedDate
        })),
        contentType: MediaType(
          'application',
          'json',
          {'charset': 'utf-8'},
        ),
      ),
    );
    if (widget.file1 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "image1",
        widget.file1.readAsBytesSync(),
        filename: "test.${widget.file1.path.split(".").last}",
      ));
    }
    if (widget.file2 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "image2",
        widget.file2.readAsBytesSync(),
        filename: "test.${widget.file2.path.split(".").last}",
      ));
    }
    if (widget.file3 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "image3",
        widget.file3.readAsBytesSync(),
        filename: "test.${widget.file3.path.split(".").last}",
      ));
    }
    if (widget.file4 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "image4",
        widget.file4.readAsBytesSync(),
        filename: "test.${widget.file4.path.split(".").last}",
      ));
    }
    if (widget.file5 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "image5",
        widget.file5.readAsBytesSync(),
        filename: "test.${widget.file5.path.split(".").last}",
      ));
    }
    if (widget.audio != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "audio",
        widget.audio.readAsBytesSync(),
        filename: "test.${widget.audio.path.split(".").last}",
      ));
    }
    if (widget.video != null) {
      request.files.add(http.MultipartFile.fromBytes(
        "video",
        widget.video.readAsBytesSync(),
        filename: "test.${widget.video.path.split(".").last}",
      ));
    }
    showdialog(context);
    request.send().then((onValue) {
      print(onValue.statusCode);
      if (onValue.statusCode == 200) {
        sendnotif();
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
                        msg: "bien enregistré !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => FirstPage()),
            (Route<dynamic> route) => false,
          );
        });
      }
      else{
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
                        msg: "erreur d 'enregistrement !!!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F7931E"),
        title: Text("CONTROLE PCP",),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backdesc.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:20.0),
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/backsimpledesc.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "DESCRIPTION",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold , fontSize: 20.0),
                ),
              ),
              //Description
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top:20.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          onChanged: (text) {
                          },
                          controller: descriptionController,
                          validator: (value2) {
                            if (value2.isEmpty) {
                              return "obligatoire !";
                            }
                            return null;
                          },
                          maxLines: 10,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Tappez votre description içi ...',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: (){
             _handleSubmitted();
            print(widget.types);
            print(widget.file1);
            print(widget.file2);
            print(widget.file3);
            print(widget.file4);
            print(widget.file5);
            print(widget.audio);
            print(descriptionController.text);
            print(formattedDate);
          },
          backgroundColor: HexColor("#F7931E"),
          child: Center(child: Text(">", style: TextStyle(color: Colors.white, fontSize: 30.0),),),
        ),
      ),
    );
  }
}