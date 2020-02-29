import 'package:calculator/provider/result_provider.dart';
import 'package:calculator/utils/themes.dart';
import 'package:calculator/widgets/history_icon_button.dart';
import 'package:calculator/widgets/keypad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Themes.cDarkBg,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: HistoryIconButton(),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.centerRight,
                  child: Consumer<ResultProvider>(
                    builder: (context, provider, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: Text(
                            "${provider.errorMessage}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              color: Themes.cVioletButton,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: '${provider.x}', style: TextStyle(fontSize: 30.0)),
                              TextSpan(
                                  text: '  ${provider.cOperator}  ',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: provider.symbolColor(provider.cOperator),
                                  ),
                              ),
                              TextSpan(text: '${provider.y}', style: TextStyle(fontSize: 30.0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: KeyPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
