import 'package:flutter/material.dart';
import 'package:flutter_app/pages/quiz_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.greenAccent,
        child: new InkWell(
          //回调点击事件,跳转到下一个页面
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => new QuizPage())),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Lets Quizzz",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold)),
              new Text("Tap to start!",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ));
    // TODO: implement build
  }
}
