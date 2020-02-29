import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/result_provider.dart';
import 'package:calculator/utils/themes.dart';
import 'package:calculator/widgets/database_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'HISTORY',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Themes.calcNumbers,
          ),
        ),
      ),
      backgroundColor: Themes.cDarkBg,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DataBaseSwitcher(),
          ),
          Expanded(
            flex: 13,
            child: Container(
                    color: Themes.cDarkButtons,
                    child: Consumer<HistoryProvider>(
                      builder: (context, provider, _) => FutureBuilder(
                          future: provider.databaseSwitcher
                              ? provider.getFBList()
                              : provider.getList(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              return ListView.builder(
                                itemCount: provider.databaseSwitcher
                                    ? provider.listOfResultsFb.length
                                    : provider.listOfResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      provider.databaseSwitcher
                                          ? provider
                                              .listOfResultsFb[index].number
                                              .toString()
                                          : provider.listOfResults[index].number
                                              .toString(),
                                      style: TextStyle(
                                        color: provider.databaseSwitcher
                                            ? Colors.orange
                                            : Themes.cVioletButton,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else
                              return Center(child: CircularProgressIndicator());
                          }),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

//FutureBuilder(
//future: provider.getList(),
//builder: (context, AsyncSnapshot snapshot) {
//if (snapshot.connectionState != ConnectionState.waiting) {
//return ListView.builder(
//itemCount: provider.listOfResults.length,
//itemBuilder: (BuildContext context, int index) {
//return Container(
//alignment: Alignment.topCenter,
//padding: EdgeInsets.only(top: 10.0),
//child: Text(
//"${provider.listOfResults[index].number}",
//style: TextStyle(
//color: Themes.cVioletButton,
//fontWeight: FontWeight.bold,
//fontSize: 30.0,
//),
//),
//);
//},
//);
