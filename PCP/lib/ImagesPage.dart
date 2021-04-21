import 'dart:io';
import 'package:PCP/AudioPage.dart';
import 'package:PCP/SelectionerType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class ImagesPage extends StatefulWidget {
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {

  File _file1;
  File _file2;
  File _file3;
  File _file4;
  File _file5;


  Future pickercamera() async {
    try{
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (myfile != null) {
        if(_file1 == null){
          _file1 = File(myfile.path);
        }
        else if(_file1 != null && _file2 == null){
          _file2 = File(myfile.path);
        }
        else if(_file1 != null && _file2 != null && _file3 == null){
          _file3 = File(myfile.path);
        }
        else if(_file1 != null && _file2 != null && _file3 != null && _file4 == null){
          _file4 = File(myfile.path);
        }
        else if(_file1 != null && _file2 != null && _file3 != null && _file4 != null && _file5 == null){
          _file5 = File(myfile.path);
        }
      }
    });
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#fe7600"),
        title: Text("CONTROLE PCP"),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   stops: [
          //     0.1,
          //     0.9,
          //   ],
          //   colors: [
          //     HexColor("#fe7600"),
          //     Colors.white
          //   ],
          // ),
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Images",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold , fontSize: 20.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  //border: Border.all(color: Colors.black, width: 1.0),
                ),
                height: 150.0,
                margin: EdgeInsets.all(10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, i){
                    // i == 0  image 1
                    if(i == 0){
                      return Container(
                        child:  _file1 == null?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.9,
                                ],
                                colors: [
                                  HexColor("#ffe263"),
                                  //Colors.black
                                  HexColor("#fe5000")
                                ],
                              ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(Icons.image, color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 1", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.file(_file1,fit: BoxFit.cover, )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 1", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      );
                    }
                    // i == 1 // image 2
                    if(i == 1 ){
                      return Container(
                        child:  _file2 == null?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.9,
                                ],
                                colors: [
                                  HexColor("#ffe263"),
                                  HexColor("#fe5000")
                                ],
                              ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(Icons.image, color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 2", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.file(_file2,fit: BoxFit.cover, )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 2", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      );
                    }
                    // i == 2// image 3
                    if(i == 2 ){
                      return Container(
                        child:  _file3 == null?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.9,
                                ],
                                colors: [
                                  HexColor("#ffe263"),
                                  HexColor("#fe5000")
                                ],
                              ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(Icons.image, color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 3", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.file(_file3,fit: BoxFit.cover, )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 3", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      );
                    }
                     // i == 3 // image 4
                    if(i == 3 ){
                      return Container(
                        child:  _file4 == null?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.9,
                                ],
                                colors: [
                                  HexColor("#ffe263"),
                                  HexColor("#fe5000")
                                ],
                              ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(Icons.image, color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 4", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.file(_file4,fit: BoxFit.cover, )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 4", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      );
                    }
                     // i == 4 // image 5
                    if(i == 4 ){
                      return Container(
                        child:  _file5 == null?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.9,
                                ],
                                colors: [
                                  HexColor("#ffe263"),
                                  HexColor("#fe5000")
                                ],
                              ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(Icons.image, color: Colors.white,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 5", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.file(_file5,fit: BoxFit.cover, )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right:40.0),
                              child: Text("Image 5", style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                ),
                ),
                // Ajoute --------------------------------------------------------------
                InkWell(
                  child: _file5 != null ?
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: 200.0,
                    height: 200.0,
                    color: Colors.grey[300],
                    child: DottedBorder(color: Colors.white,
                      radius: Radius.circular(10),
                      dashPattern: [6],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.done ,size: 50,color: Colors.green,
                          ),
                          Text("Done !"),
                          ],
                        ),
                      ),
                    ),
                  ):
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo,size: 50,color: Colors.white,
                              ),
                              Text("Ajouter", style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),  
                      ),
                    onTap: (){
                      pickercamera();
                    },
                  ),
                  ),
                // Button
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                width: double.infinity,
                height: 50.0,
                child: RaisedButton.icon(
                  onPressed: () {
                    //_handleSubmitted();
                    Navigator.push(context, MaterialPageRoute(
                      builder:  (context) => AudioPage()),
                    );

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