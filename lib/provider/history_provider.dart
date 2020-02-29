import 'package:calculator/models/calculation_result.dart';
import 'package:calculator/utils/database_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HistoryProvider with ChangeNotifier {

  String _uniqueId;
  String get uniqueId => _uniqueId;
  set uniqueId(String value) {
    _uniqueId = value;
    notifyListeners();
  }

  bool _databaseSwitcher = false;
  bool get databaseSwitcher => _databaseSwitcher;
  set databaseSwitcher(bool value) {
    _databaseSwitcher = value;
    notifyListeners();
  }

  List<CalculationResult> _listOfResults = [];
  List<CalculationResult> get listOfResults => _listOfResults;
  set listOfResults(List<CalculationResult> value) {
    _listOfResults = value;
    notifyListeners();
  }

  List<CalculationResult> _listOfResultsFb = [];
  List<CalculationResult> get listOfResultsFb => _listOfResultsFb;
  set listOfResultsFb(List<CalculationResult> value) {
    _listOfResultsFb = value;
    notifyListeners();
  }

  Future<void> getList() async {
    List<Map<String, dynamic>> receivedList = await DatabaseHelper().readData();
    List<CalculationResult> tempCalcList = [];
    for (Map n in receivedList) {
      CalculationResult cR = CalculationResult.fromMapObject(n);
      tempCalcList.add(cR);
    }
    _listOfResults = tempCalcList;
  }

  Future<void> getFBList() async {

    QuerySnapshot fbList = await Firestore.instance.collection('users')
        .document(_uniqueId).collection('results').getDocuments();
    List<CalculationResult> tempFbList = [];
    List<DocumentSnapshot>  itList = List.from(fbList.documents);
    for (DocumentSnapshot n in itList) {
      CalculationResult fR = CalculationResult.fromMapObject(n.data);
      tempFbList.add(fR);
    }
    _listOfResultsFb = tempFbList;
  }


}