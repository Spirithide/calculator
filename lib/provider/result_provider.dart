import 'package:calculator/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultProvider with ChangeNotifier {

  String _result;
  get result => _result;
  set result(String value) {
    _result = value;
    notifyListeners();
  }

  String _x = '';
  get x => _x;
  set x(String value) {
    _x += value;
    notifyListeners();
  }

  String _y = '';
  get y => _y;
  set y(String value) {
    _y += value;
    notifyListeners();
  }

  String _cOperator = '';
  get cOperator => _cOperator;
  set cOperator(String value) {
    _cOperator = value;
    notifyListeners();
  }

  String _errorMessage = '';
  get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  void onPressedNumbers(String value) {
    if (_x == '' && value == '0') {
      _errorMessage = 'Please enter a natural number';
    } else if (_y == '' && value == '0' && _cOperator != '') {
      _errorMessage = 'Please enter a natural number';
    } else if (_cOperator == '') {
      _errorMessage = '';
      if(_x.length < 10) {
        _x += value;
      } else {
        _errorMessage = 'Hold on Sheriff, this number is big enough, try choosing operator now';
      }
    } else {
      _errorMessage = '';
      if(_y.length < 10) {
        _y += value;
      } else {
        _errorMessage = 'Whew, I can\'t handle anymore of these numbers! Press equals to see the result ;)';
      }
    }

    notifyListeners();
  }

  void onPressedOperators(String value) {
    if (x != '' && y == '') {
      _errorMessage = '';
      _cOperator = value;
    } else if (x != '' && y!= '') {
      _errorMessage = 'Only one calculation allowed';
    } else {
      _errorMessage = 'Please enter numbers first';
    }
    notifyListeners();
  }

  void onPressedErase() {
    _errorMessage = '';
    _x = '';
    _y = '';
    _cOperator = '';
    notifyListeners();
  }

  void onPressedEquals(String first, String second, String op) {
    if ( first == '' || second == '') {
      _errorMessage = 'Two variables are needed for the equation';
      notifyListeners();
    } else {
      _errorMessage = '';
      num calculationR = _resultCalculation(int.parse(first), int.parse(second), op);
      String tempResult = calculationR.toStringAsFixed(3);
      List<String> splitNumber = tempResult.split('.');

      if ((splitNumber[1] == '0') || (splitNumber[1] == '00') || (splitNumber[1] == '000')) {
        tempResult = splitNumber[0];
      } else {
        tempResult = '${splitNumber[0]}.${splitNumber[1]}';
      }
      _result = tempResult;
     // _result = num.parse(calculationR.toStringAsFixed(3));

      notifyListeners();
    }

  }

  num _resultCalculation(int x, int y, String op) {
    switch (op) {
      case '+':
        return x + y;
      case '-':
        return x - y;
      case '*':
        return x * y;
      case '/':
        return x / y;
      default:
        return 0;
    }
  }

  Color symbolColor(String symbol) {
    if (symbol == '+') {
      return Colors.amber;
    }
    if (symbol == '-') {
      return Colors.deepPurpleAccent;
    }
    if (symbol == '*') {
      return Colors.pinkAccent;
    }
    if (symbol == '/') {
      return Colors.orange;
    }
    return Themes.calcNumbers;
  }

}
