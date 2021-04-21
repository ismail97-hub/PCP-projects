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

  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  
  String description;
  TextEditingController descriptionController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      print("Error here !!!! ");
    } else {
      form.save();
      print(description);
      showdialog(context);
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
      // upload();
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
                  CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.grey),
                    strokeWidth: 2,
                  ),
                ],
              ),
            ),
          );
        });
  }
  String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  // Future upload() async {
  //   String url= "http://192.168.1.30:8080/Panne/";
  //   for (var i = 0; i < widget.types.length; i++) {
  //     if(i==0){
  //       url+=widget.types[i].toString(); 
  //     }
  //     else{
  //       url+=","+widget.types[i].toString();
  //     }
  //   }
  //   print(url);
  //   var request = http.MultipartRequest(
  //       "POST", Uri.parse(url));
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };

  //   request.headers["Content-Type"] = 'multipart/form-data';
  //   request.files.add(
  //     http.MultipartFile.fromBytes(
  //       'panne',
  //       utf8.encode(json.encode(<String, String>{
  //         "description": descriptionController.text,
  //         "date": formattedDate
  //       })),
  //       contentType: MediaType(
  //         'application',
  //         'json',
  //         {'charset': 'utf-8'},
  //       ),
  //     ),
  //   );
  //   if (widget.file1 != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "image1",
  //       widget.file1.readAsBytesSync(),
  //       filename: "test.${widget.file1.path.split(".").last}",
  //     ));
  //   }
  //   if (widget.file2 != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "image2",
  //       widget.file2.readAsBytesSync(),
  //       filename: "test.${widget.file2.path.split(".").last}",
  //     ));
  //   }
  //   if (widget.file3 != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "image3",
  //       widget.file3.readAsBytesSync(),
  //       filename: "test.${widget.file3.path.split(".").last}",
  //     ));
  //   }
  //   if (widget.file4 != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "image4",
  //       widget.file4.readAsBytesSync(),
  //       filename: "test.${widget.file4.path.split(".").last}",
  //     ));
  //   }
  //   if (widget.file5 != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "image5",
  //       widget.file5.readAsBytesSync(),
  //       filename: "test.${widget.file5.path.split(".").last}",
  //     ));
  //   }
  //   if (widget.audio != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //       "audio",
  //       widget.audio.readAsBytesSync(),
  //       filename: "test.${widget.audio.path.split(".").last}",
  //     ));
  //   }
  //   showdialog(context);
  //   request.send().then((onValue) {
  //     print(onValue.statusCode);
  //     if (onValue.statusCode == 200) {
  //       Timer(Duration(seconds: 3), () {
  //         Navigator.of(context).pop();
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => FirstPage()),
  //           (Route<dynamic> route) => false,
  //         );
  //       });
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#fe7600"),
        title: Text("CONTROLE PCP",),
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
              //Description
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top:60.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20.0,color: Colors.white),
                        ),
                      ),
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
              // Button
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                width: double.infinity,
                height: 50.0,
                child: RaisedButton.icon(
                  onPressed: () {
                    _handleSubmitted();
                    // print(widget.types);
                    // print(widget.file1);
                    // print(widget.file2);
                    // print(widget.file3);
                    // print(widget.file4);
                    // print(widget.file5);
                    // print(widget.audio);
                    print(descriptionController.text);
                    print(formattedDate);

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(30.0))),
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
}