import 'package:PCP/ImagesPage.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
     return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: MaterialButton(
          height: 200.0,
          elevation: 10.0,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImagesPage()));
          },
          color: Colors.black38,
          textColor: Colors.white,
          child: Text("Ajoutez une panne", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}