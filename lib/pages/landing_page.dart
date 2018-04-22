import 'package:flutter/material.dart';
import './quiz_page.dart';

class LandingPage extends StatelessWidget {

  void gotoQuizPage(BuildContext context){
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new QuizPage()
    ));
  } 

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new InkWell(
        onTap: () => gotoQuizPage(context),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Code Quiz',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold
              ),
            ),
            new Text('Tap to start!',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}