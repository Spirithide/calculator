import 'package:calculator/utils/enums.dart';
import 'package:calculator/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:calculator/widgets/calculator_button.dart';

class KeyPad extends StatelessWidget {
  final List<String> numbersC1 = ['7', '4', '1'];
  final List<String> numbersC2 = ['8', '5', '2'];
  final List<String> numbersC3 = ['9', '6', '3'];
  final List<String> operators = ['/', '*', '-'];

  List<Widget> _createColumn(int length, List<String> list, double buttonSize, Color color, ButtonFunctions function) {
    return List<Widget>.generate(length, (int index) {
      return CalculatorButton(
        buttonSize: buttonSize,
        index: index,
        symbols: list,
        color: color,
        function: function,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final double buttonSize = size.width/5;
    
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _createColumn(numbersC1.length, numbersC1, buttonSize, Themes.cDarkButtons, ButtonFunctions.numbers),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _createColumn(numbersC2.length, numbersC2, buttonSize, Themes.cDarkButtons, ButtonFunctions.numbers),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _createColumn(numbersC3.length, numbersC3, buttonSize, Themes.cDarkButtons,  ButtonFunctions.numbers),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _createColumn(operators.length, operators, buttonSize, Themes.cPaleButtons,  ButtonFunctions.operators),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CalculatorButton(
                color: Themes.cDarkButtons,
                buttonSize: buttonSize,
                symbols: ['C'],
                index: 0,
                function: ButtonFunctions.erase,
              ),
              CalculatorButton(
                color: Themes.cDarkButtons,
                buttonSize: buttonSize,
                symbols: ['0'],
                index: 0,
                function: ButtonFunctions.numbers,
              ),
              CalculatorButton(
                color: Themes.cVioletButton,
                buttonSize: buttonSize,
                symbols: ['='],
                index: 0,
                function: ButtonFunctions.equals,
              ),
              CalculatorButton(
                color: Themes.cPaleButtons,
                buttonSize: buttonSize,
                symbols: ['+'],
                index: 0,
                function: ButtonFunctions.operators,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
