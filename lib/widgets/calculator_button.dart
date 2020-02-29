import 'package:calculator/models/calculation_result.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/result_provider.dart';
import 'package:calculator/ui/result_screen.dart';
import 'package:calculator/utils/database_helper.dart';
import 'package:calculator/utils/enums.dart';
import 'package:calculator/utils/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_udid/flutter_udid.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {Key key,
      @required this.symbols,
      @required this.buttonSize,
      @required this.color,
      @required this.function,
      @required this.index})
      : super(key: key);

  final List<String> symbols;
  final int index;
  final double buttonSize;
  final Color color;
  final ButtonFunctions function;

  @override
  Widget build(BuildContext context) {

    CalculationResult caResult;
    DatabaseHelper databaseHelper = DatabaseHelper();

    final provider = Provider.of<ResultProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    Future<void> setData({@required String number}) async {
      String uniqueDeviceId = await FlutterUdid.consistentUdid;
      String documentId = DateTime.now().toIso8601String();
      historyProvider.uniqueId = uniqueDeviceId.substring(0, 50);
      await Firestore.instance.collection('users').document(historyProvider.uniqueId)
          .collection('results').document('$documentId').setData({
        'number' : number,
      });
    }

    return Container(
      height: buttonSize,
      width: buttonSize,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Themes.cButtonSplash,
          highlightColor: Themes.cButtonSplash,
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onTap: () {
            if (function == ButtonFunctions.numbers) {
              provider.onPressedNumbers(symbols[index]);
            }
            if (function == ButtonFunctions.operators) {
              provider.onPressedOperators(symbols[index]);
            }
            if (function == ButtonFunctions.equals) {
              provider.onPressedEquals(
                  provider.x, provider.y, provider.cOperator);
              if (provider.result != null && provider.x != '' && provider.y != '') {

                //writing to Local Database
                caResult = CalculationResult(provider.result.toString());
                databaseHelper.insertCalculationResult(caResult);

                Future<List<Map<String, dynamic>>> nList = databaseHelper.readData(); //TODO: delete
                print(nList);
                // writing to Firebase
               setData(number: provider.result.toString());

               //
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        result: provider.result,
                        color: provider.symbolColor(provider.cOperator),
                      ),
                    ));
              }
            }
            if (function == ButtonFunctions.erase) {
              provider.onPressedErase();
            }
          },
          child: Center(
            child: Text(
              symbols[index],
              style: TextStyle(
                fontSize: 30,
                color: provider.symbolColor(symbols[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
