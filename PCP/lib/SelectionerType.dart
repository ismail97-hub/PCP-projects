import 'dart:convert';
import 'dart:io';
import 'package:PCP/FinalPage.dart';
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
  void loadtypes(){
    String url = "http://192.168.1.30:8080/TypePanne";
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
    // print(widget.file1);
    // print(widget.file2);
    // print(widget.file3);
    // print(widget.file4);
    // print(widget.file5);
    // print(widget.audio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:HexColor("#fe7600"),
        elevation: 0.0,
        title:Text("CONTROLE PCP"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover     
          )
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left:20,right:20,top:30),
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
                    children: [
                      Container(padding: EdgeInsets.only(right:5.0,bottom: 8,top:10,left:5.0),child: Text("Sélectionnez les types de panne",style:TextStyle(color:Colors.orange[900],fontWeight: FontWeight.bold,fontSize: 18),)),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(bottom:10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: ClampingScrollPhysics(),
                          itemCount: listtypelength(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  // checkColor: Colors.orange[900],
                                  focusColor: Colors.orange[900],
                                  hoverColor: Colors.orange[900],
                                  activeColor: Colors.orange[900],
                                  value: _isChecked[index],
                                  onChanged: (value) {
                                    setState(() {
                                     _isChecked[index] = value;
                                    });
                                  },
                                ),
                                Text(listType[index]["libelle"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
             Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                width: double.infinity,
                height: 50.0,
                child: RaisedButton.icon(
                  onPressed: () {
                    //_handleSubmitted();
                    
                    print(_isChecked);
                    for (var i = 0; i < _isChecked.length; i++) {
                      if(_isChecked[i]==true){
                        idtypeschecked.add(listType[i]["idTypePanne"]);
                      }
                    }
                    print(idtypeschecked);
                    Navigator.push(context, MaterialPageRoute(
                      builder:  (context) => FinalPage(widget.file1,widget.file2,widget.file3,widget.file4,widget.file5,widget.audio,widget.video,idtypeschecked)),
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
    );
  }
}