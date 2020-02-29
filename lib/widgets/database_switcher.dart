import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:provider/provider.dart';

class DataBaseSwitcher extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    Future<void> getUniqueDeviceId() async {
      String uniqueDeviceId = await FlutterUdid.consistentUdid;
      historyProvider.uniqueId = uniqueDeviceId.substring(0, 50);

    }

    return Consumer<HistoryProvider>(
      builder: (context, provider, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Local',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: !provider.databaseSwitcher ? Themes.cVioletButton : Themes.cPaleButtons,
            ),
          ),
          Switch(
            value: provider.databaseSwitcher,
            onChanged: (value) {
              historyProvider.databaseSwitcher = value;
              getUniqueDeviceId();
              historyProvider.getFBList();
            },
            inactiveThumbColor: Themes.calcNumbers,
            inactiveTrackColor: Themes.cVioletButton,
            activeTrackColor: Colors.orange,
            activeColor: Themes.calcNumbers,
          ),
          Text(
            'FireBase',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: !provider.databaseSwitcher ? Themes.cPaleButtons : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
