import 'package:calculator/ui/history_screen.dart';
import 'package:calculator/utils/themes.dart';
import 'package:flutter/material.dart';

class HistoryIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: 20.0),
      icon: Icon(Icons.history,
        color: Themes.cVioletButton,
        size: 40.0,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HistoryScreen(),
        ));
      },
    );
  }
}
