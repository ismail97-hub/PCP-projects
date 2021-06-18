import 'dart:io';
import 'package:PCP/VideoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'AudioPage.dart';

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
        backgroundColor: HexColor("#F7931E"),
        title: Text("CONTROLE PCP"),
        elevation: 0.0,
        // POPUP MENU SUPPRIMER TOUT
        actions: [
          IconButton(
            icon: Icon(
              Icons.video_call,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder:  (context) => VideoPage()),
              );
            },
          ),
          PopupMenuButton(
            onSelected: (result){
              if(result == 0){
                setState(() {
                  _file1 = null;
                  _file2 = null;
                  _file3 = null;
                  _file4 = null;
                  _file5 = null;
                });
              }
            },
            itemBuilder: (context){
              return [
                PopupMenuItem(
                  child: Text("Supprimer tout"),
                  value: 0,
                ),
              ];
            }
          )
        ],
      ),
      // BODY--------------------------------------------------------------------------
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backimagepcp.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // IMAGE PIC
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/imagesimple2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //TITLE
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20.0 ),
                child: Text("IMAGE",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold , fontSize: 20.0),
                ),
              ),
              //BUTTON AJOUTER --------------------------------------------------------------
              Container(
                child: _file5 != null ?
                // DONE !
                Container(
                  //margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  width: 150.0,
                  height: 150.0,
                  color: Colors.grey[300],
                  child: DottedBorder(color: Colors.black,
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
                // ADD
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
                    pickercamera();
                  },
                )
              ),
              // LIST PICS ---------------------------------------------------------------------
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 130.0,
                margin: EdgeInsets.only(left: 5.0,right:5.0,top: 20.0, bottom: 80.0),
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
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/imageempty.png"),
                                  fit: BoxFit.cover,
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
                            //file 1 exist --
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: Stack(
                                fit: StackFit.expand,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.0, top: 6.0),
                                        child: Icon(Icons.cancel, color: Colors.white),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          // file1
                                          _file1 = null;
                                          _file1 = _file2;
                                          _file2 = _file3;
                                          _file3 = _file4;
                                          _file4 = _file5;
                                          _file5 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/imageempty.png"),
                                  fit: BoxFit.cover,
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
                            //file 2 exist --
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: Stack(
                                fit: StackFit.expand,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.0, top: 6.0),
                                        child: Icon(Icons.cancel, color: Colors.white),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          //_file1 = _file2;
                                          _file2 = null;
                                          _file2 = _file3;
                                          _file3 = _file4;
                                          _file4 = _file5;
                                          _file5 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/imageempty.png"),
                                  fit: BoxFit.cover,
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
                            //file 3 exist --
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: Stack(
                                fit: StackFit.expand,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.0, top: 6.0),
                                        child: Icon(Icons.cancel, color: Colors.white),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          //file3
                                          //_file1 = _file2;
                                          //_file2 = _file3;
                                          _file3 = null;
                                          _file3 = _file4;
                                          _file4 = _file5;
                                          _file5 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/imageempty.png"),
                                  fit: BoxFit.cover,
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
                            //file 4 exist --
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: Stack(
                                fit: StackFit.expand,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.0, top: 6.0),
                                        child: Icon(Icons.cancel, color: Colors.white),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          //file4
                                          //_file1 = _file2;
                                          //_file2 = _file3;
                                          //_file3 = _file4;
                                          _file4 = null;
                                          _file4 = _file5;
                                          _file5 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/imageempty.png"),
                                  fit: BoxFit.cover,
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
                            //file 4 exist --
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: Stack(
                                fit: StackFit.expand,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.0, top: 6.0),
                                        child: Icon(Icons.cancel, color: Colors.white),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          // _file1 = _file2;
                                          // _file2 = _file3;
                                          // _file3 = _file4;
                                          // _file4 = _file5;
                                          _file5 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: (){
              if(_file1==null){
                  Fluttertoast.showToast(
                  msg: "Vous devez prendre une photo !!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: HexColor("#F7931E"),
                  textColor: Colors.white,
                  fontSize: 16.0);  
              }
              else
              {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder:  (context) => AudioPage(file1: _file1,file2: _file2,file3: _file3,file4: _file4,file5: _file5)),
                );
              }  
          },
          backgroundColor: HexColor("#F7931E"),
          child: Center(child: Text(">", style: TextStyle(color: Colors.white, fontSize: 30.0),),),
        ),
      ),
    );
  }
}
	
	
	
	
	
	
