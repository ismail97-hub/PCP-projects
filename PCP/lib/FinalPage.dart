import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FinalPage extends StatefulWidget {
  final List<int> types;
  final File file1;
  final File file2;
  final File file3;
  final File file4;
  final File file5;
  final File audio;
  FinalPage(this.types,this.file1,this.file2,this.file3,this.file4,this.file5,this.audio);
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
    }
  }


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
                    print(widget.types);
                    print(widget.file1);
                    print(widget.file2);
                    print(widget.file3);
                    print(widget.file4);
                    print(widget.file5);

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