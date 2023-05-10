//patientInfoCheck
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:led_bulb_indicator/led_bulb_indicator.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Findpat extends StatefulWidget {
  const Findpat({Key? key, required this.server});

  final BluetoothDevice server;

  @override
  State<Findpat> createState() => _FindpatState();
}

class _Message {
  int timestamp;
  String data;

  _Message(this.timestamp, this.data);
}

class _FindpatState extends State<Findpat> {
  List<bool> sensor_status = [false, false, false, false, false, false, false];

  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    setState(() {
      sensor_status = data.reversed.map((x) => x == 49).toList();
    });
    print(sensor_status);
    // data.forEach((byte) {
    //   if (byte == 8 || byte == 127) {
    //     backspacesCounter++;
    //   }
    // });
    // Uint8List buffer = Uint8List(data.length - backspacesCounter);
    // int bufferIndex = buffer.length;

    // // Apply backspace control character
    // backspacesCounter = 0;
    // for (int i = data.length - 1; i >= 0; i--) {
    //   if (data[i] == 8 || data[i] == 127) {
    //     backspacesCounter++;
    //   } else {
    //     if (backspacesCounter > 0) {
    //       backspacesCounter--;
    //     } else {
    //       buffer[--bufferIndex] = data[i];
    //     }
    //   }
    // }

    // // Create message if there is new line character
    // String dataString = String.fromCharCodes(buffer);
    // print(dataString);
    // int index = buffer.indexOf(13);
    // if (~index != 0) {
    //   setState(() {
    //     messages.add(
    //       _Message(
    //         1,
    //         backspacesCounter > 0
    //             ? _messageBuffer.substring(
    //                 0, _messageBuffer.length - backspacesCounter)
    //             : _messageBuffer + dataString.substring(0, index),
    //       ),
    //     );
    //     _messageBuffer = dataString.substring(index);
    //   });
    // } else {
    //   _messageBuffer = (backspacesCounter > 0
    //       ? _messageBuffer.substring(
    //           0, _messageBuffer.length - backspacesCounter)
    //       : _messageBuffer + dataString);
    // }
  }

  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      print("name : ${widget.server.name}");
      print("Address: ${widget.server.address}");
      print("Type: ${widget.server.type}");
      print("State: ${widget.server.bondState}");
      print("Is connected: ${!widget.server.isConnected}");
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      try {
        connection!.input!.listen(_onDataReceived).onDone(() {
          // Example: Detect which side closed the connection
          // There should be `isDisconnecting` flag to show are we are (locally)
          // in middle of disconnecting process, should be set before calling
          // `dispose`, `finish` or `close`, which all causes to disconnect.
          // If we except the disconnection, `onDone` should be fired as result.
          // If we didn't except this (no flag set), it means closing by remote.
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });
      } catch (e) {
        print(e);
      }
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Box sensor checking'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
/*
                    Table(
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(children: [
                          Text('Cell 1'),
                          Text('Cell 2'),
                          Text('Cell 3'),
                        ]),
                        TableRow(children: [
                          Text('Cell 4'),
                          Text('Cell 5'),
                          Text('Cell 6'),
                        ])
                      ],
                    ),
 */

                    Padding(padding: EdgeInsets.all(5.0)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'การตรวจสอบเซนเซอร์     ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'หากเซนเซอร์ตรวจพบยาสถานะ  ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        LedBulbIndicator(
                          initialState: LedBulbColors.green,
                          glow: false,
                          size: 12,
                        ),
                        Text(
                          '  จะปรากฎ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'หากเซนเซอร์ไม่ตรวจพบยาสถานะ  ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        LedBulbIndicator(
                          initialState: LedBulbColors.red,
                          glow: false,
                          size: 12,
                        ),
                        Text(
                          '  จะปรากฎ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      height: 10.0,
                      child: new Center(
                        child: new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 9.0, end: 9.0),
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'ช่องยา   ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 220,
                        ),
                        Text(
                          'ตรวจพบยา',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 23,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันจันทร์   ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 222,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[0] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[0] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันอังคาร  ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 221,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[1] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[1] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันพุธ ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 263,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[2] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[2] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันพฤหัสบดี',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 202,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[3] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[3] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันศุกร์   ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 236,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[4] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[4] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันเสาร์   ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 232,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[5] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[5] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          'วันอาทิตย์ ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 216,
                        ),
                        LedBulbIndicator(
                          initialState: sensor_status[6] == true
                              ? LedBulbColors.green
                              : LedBulbColors.red,
                          glow: sensor_status[6] == true ? true : false,
                          size: 20,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 33.0,
                        ),
                        Padding(padding: EdgeInsets.all(33.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            minimumSize: Size(135, 30),
                          ),
                          onPressed: () => {},
                          child: const Text(
                            'NEXT/ถัดไป',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(4.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blue,
                            minimumSize: Size(20, 30),
                          ),
                          onPressed: () => {Navigator.of(context).pop()},
                          child: const Text('CANCEL/ยกเลิก'),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(1.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
