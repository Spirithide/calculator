import 'package:calculator/utils/themes.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key, @required this.result, @required this.color}) : super(key: key);

  final String result;
  final Color color;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'RESULT',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            result,
            style: TextStyle(
              fontSize: result.toString().length > 13 ? 28.0 : 44.0,
              fontWeight: FontWeight.bold,
              color: Themes.cDarkBg
            ),
          ),
        ),
      ),
    );
  }



}
