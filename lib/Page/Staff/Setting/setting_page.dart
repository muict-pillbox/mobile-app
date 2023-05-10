import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:pillbox_app/Page/Staff/Setting/setting_page/bluetooth_setting_page.dart';
import 'package:pillbox_app/Page/Staff/Setting/setting_page/sensor_check_page.dart';

import '../PatientSearch/patient_search_page.dart';

class SettingPage extends StatelessWidget {
  final BluetoothDevice? device;

  SettingPage({Key? key, this.device}) : super(key: key);
  late String bluetoothDetail = '';

  @override
  Widget build(BuildContext context) {
    if (device != null) {
      bluetoothDetail =
          "Connecting to ${device!.name.toString()}:${device!.address.toString()}";
    }

    return Scaffold(
      appBar: AppBar(title: Text('Setting Page')),
      body: Column(
        children: <Widget>[
          Text(bluetoothDetail),
          Padding(padding: EdgeInsets.all(6)),
          buildPatienSearchButton(context),
          buildBluetoothSettingButton(context),
          buildSensorCheckhButton(context),
        ],
      ),
    );
  }

  Widget buildSensorCheckhButton(BuildContext context) => ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.fromHeight(50),
          backgroundColor: Colors.blue,
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Sensor Check',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Findpat(
                server: BluetoothDevice(
                    name: 'Pillbox Prototype-0',
                    address: 'A4:CF:12:98:49:0E',
                    type: BluetoothDeviceType.classic,
                    isConnected: false)),
          ));
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      );

  Widget buildPatienSearchButton(BuildContext context) => ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.fromHeight(50),
          backgroundColor: Colors.blue,
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Patient Search',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PatientSearchPage(),
          ));
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      );

  Widget buildBluetoothSettingButton(BuildContext context) => ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.fromHeight(50),
          backgroundColor: Colors.blue,
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Bluetooth Setting',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BluetoothSettingPage(),
          ));
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      );
}
