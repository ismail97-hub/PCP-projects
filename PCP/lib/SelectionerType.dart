import 'dart:convert';
import 'dart:io';
import 'package:PCP/FinalPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectionerType extends StatefulWidget {
  final File file1;
  final File file2;
  final File file3;
  final File file4;
  final File file5;
  final File audio; 
  final File video;
  SelectionerType(this.file1,this.file2,this.file3,this.file4,this.file5,this.audio,this.video);
  @override
  _SelectionerTypeState createState() => _SelectionerTypeState();
}

class _SelectionerTypeState extends State<SelectionerType> {
  List<dynamic> listType;
  List<int> idtypeschecked = List<int>();
  List<dynamic> selectedTypes = List<dynamic>();


  void loadtypes(){
    String url = "http://192.168.1.59:8060/TypePanne";
    http.get(url).then((resp) {
      setState(() {
         this.listType = json.decode(utf8.decode(resp.bodyBytes));
        _isChecked = List<bool>.filled(listType.length, false);
        print(listType);
      });
    }).catchError((err) {
      print(err);
    });
  }
  
  int listtypelength(){
    if(listType==null){
      return 0;
    }
    else{
      return listType.length;
    }
  }
  // var listType = ['type A', 'type B', 'type C'];
  List<bool> _isChecked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     loadtypes();
   // _isChecked = List<bool>.filled(listType.length, false);
    print(widget.file1);
    print(widget.file2);
    print(widget.file3);
    print(widget.file4);
    print(widget.file5);
    print(widget.video);
    print(widget.audio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#ff931e"),
        elevation: 0.0,
        title:Text("CONTROLE PCP"),
        actions: [
          myAppBarIcon()
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgST.png"),
              fit: BoxFit.cover     
            )
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:20.0),
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/STpng.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(top:10,bottom:20),child: Text("LES TYPES",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),)),
              for (var i = 0; i < listtypelength(); i++)
              Dismissible(
                key: UniqueKey(),
                child: Container(height: 60,child: Card(child: Center(child: Text("${listType[i]["libelle"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)))),
                background: Container(
                  color: HexColor("#019D78"),
                  child: Icon(Icons.check)
                ),
                direction: listtypelength()==1?null:DismissDirection.horizontal ,
                onDismissed: (DismissDirection direction){
                  setState(() {
                    selectedTypes.add(listType[i]);
                    _incrementCounter();
                    listType.removeAt(i);
                  });
                },
                // secondaryBackground: Container(
                //   color: Colors.red,
                //   child: Icon(Icons.cancel),
                // ),
              ),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.only(left:20,right:20),
              //     decoration: new BoxDecoration(
              //       boxShadow: [
              //         new BoxShadow(
              //           color: Colors.black26,
              //           blurRadius: 10.0,
              //         ),
              //       ],
              //     ),
              //     child: Card(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //       // color: Colors.transparent,
              //       // elevation: 0.0,
              //       child: Column(
              //         children: [
              //           // Container(padding: EdgeInsets.only(right:5.0,bottom: 8,top:10,left:5.0),child: Text("Sélectionnez les types de panne",style:TextStyle(color:Colors.orange[900],fontWeight: FontWeight.bold,fontSize: 18),)),
              //           // Divider(),
              //           Container(
              //             margin: EdgeInsets.only(bottom:10),
              //             child: ListView.builder(
              //               shrinkWrap: true,
              //               padding: EdgeInsets.zero,
              //               physics: ClampingScrollPhysics(),
              //               itemCount: listtypelength(),
              //               itemBuilder: (context, index) {
              //                 return Column(
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Checkbox(
              //                           // checkColor: Colors.orange[900],
              //                           focusColor: Colors.blue[700],
              //                           hoverColor: Colors.blue[700],
              //                           activeColor: Colors.blue[700],
              //                           value: _isChecked[index],
              //                           onChanged: (value) {
              //                             setState(() {
              //                              _isChecked[index] = value;
              //                             });
              //                           },
              //                         ),
              //                         Text(listType[index]["libelle"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                      
              //                       ],
              //                     ),
                                  
              //                     if(index!=listtypelength()-1)
              //                     Divider(),
              //                   ],
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              //  Container(
              //     margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              //     width: double.infinity,
              //     height: 50.0,
              //     child: RaisedButton.icon(
              //       onPressed: () {
              //         //_handleSubmitted();
                      
              //         print(_isChecked);
              //         for (var i = 0; i < _isChecked.length; i++) {
              //           if(_isChecked[i]==true){
              //             idtypeschecked.add(listType[i]["idTypePanne"]);
              //           }
              //         }
              //         print(idtypeschecked);
              //         // Navigator.push(context, MaterialPageRoute(
              //         //   builder:  (context) => FinalPage(widget.file1,widget.file2,widget.file3,widget.file4,widget.file5,widget.audio,widget.video,idtypeschecked)),
              //         // ); 
              //       },
              //       shape: RoundedRectangleBorder(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(30.0))),
              //       label: Text(
              //         'Suivant',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       icon: Icon(
              //         Icons.send,
              //         color: Colors.white,
              //       ),
              //       textColor: Colors.white,
              //       // color: HexColor("#318aff"),//blue
              //       color: Colors.black38,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
      
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: (){
            if (selectedTypes.length==0) {
                Fluttertoast.showToast(
                  msg: "veuillez sélectionner un type !!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: HexColor("#ff931e"),
                  textColor: Colors.white,
                  fontSize: 16.0
                );
            } else {
                for (var i = 0; i < selectedTypes.length; i++) {
                    idtypeschecked.add(selectedTypes[i]["idTypePanne"]);
                }
                print(idtypeschecked);
                Navigator.of(context).push(CupertinoPageRoute(
                  builder:  (context) => FinalPage(widget.file1,widget.file2,widget.file3,widget.file4,widget.file5,widget.audio,widget.video,idtypeschecked)),
                );
            }
             
          },
          backgroundColor: HexColor("#F7931E"),
          child: Center(child: Text(">", style: TextStyle(color: Colors.white, fontSize: 30.0),),),
        ),
      ),
    );
  }
  
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Widget myAppBarIcon(){
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(padding: EdgeInsets.all(15),child: Center(child: Text("les types sélectionnés",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)),
                    for (var i = 0; i < selectedTypes.length; i++) 
                      ListTile(
                        title: new Text("-     "+selectedTypes[i]["libelle"].toString()),
                      ),
                  ],
                ),
              );
            }
        );            
      },
      child: Container(
        // width: 30,
        // height: 30,
        margin:EdgeInsets.all(10),
        child: Stack(
          children: [
            Icon(
              Icons.list,
              color: Colors.white,
              size: 35,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 2),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      _counter.toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}