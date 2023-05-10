import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Main/patient_main_page.dart';

enum DialogAction { yws, cancel }

class TimeSetMed extends StatefulWidget {
  const TimeSetMed({Key? key}) : super(key: key);

  @override
  State<TimeSetMed> createState() => _TimeSetMedState();
}

class _TimeSetMedState extends State<TimeSetMed> {
  //final HttpService httpService = HttpService();
  TimeOfDay _Time = TimeOfDay(hour: 0, minute: 00);
  TimeOfDay initialTime = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 00);
  final globalVariable = const FlutterSecureStorage();

  final _numTimesController = TextEditingController();
  final _numPillsController = TextEditingController();

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _Time);
    print("${picked!.hour}  ${picked.minute}");
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text('ตั้งค่าการทานยาและการเตือน'),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.home),
              )),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(3.0)),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(3.0)),
                        Row(
                          children: [
                            Text('ระบุจำนวนครั้งในการทานยา'),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(3.0)),
                        Container(
                          width: 400,
                          child: TextFormField(
                            controller: _numTimesController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // fillColor: Colors.green,
                              labelText: 'ระบุจำนวนครั้งในการทานยา',
                              prefixIcon: Icon(Icons.medication),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text('จำนวนเม็ดยาที่ผู้ป่วยต้องรับประทาน'),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(3.0)),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Container(
                          width: 400,
                          child: TextFormField(
                            controller: _numPillsController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // fillColor: Colors.green,
                              labelText:
                                  'ระบุจำนวนเม็ดยาที่ผู้ป่วยต้องรับประทาน',
                              prefixIcon: Icon(Icons.medication_outlined),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text('เวลาเริ่มต้นการทานยาในแต่ละวัน'),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(3.0)),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Container(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay picked = await _selectTime();
                              print(picked);
                              setState(() {
                                initialTime = picked;
                              });
                            },
                            child: Text('เลือกเวลา'),
                          ),
                        ),
                        Row(
                          children: [
                            Text('เวลาสิ้นสุดการทานยาในแต่ละวัน'),
                          ],
                        ),
                        Text(
                          'Selected time: ${initialTime.format(context)}',
                        ),
                        Padding(padding: EdgeInsets.all(3.0)),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Container(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay picked = await _selectTime();
                              print(picked);
                              setState(() {
                                endTime = picked;
                              });
                            },
                            child: Text('เลือกเวลา'),
                          ),
                        ),
                        Text(
                          'Selected time: ${endTime.format(context)}',
                        ),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Padding(padding: EdgeInsets.all(20.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            minimumSize: Size(20, 30),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: (_numTimesController.text.isEmpty ||
                                            _numPillsController.text.isEmpty
                                        ? Text("Error")
                                        : Text("Save change")),
                                    content: (_numTimesController
                                                .text.isEmpty ||
                                            _numPillsController.text.isEmpty
                                        ? Text("ใส่ของมูลลงในช่อง " +
                                            (_numTimesController.text.isEmpty
                                                ? "ระบุจำนวนครั้ง"
                                                : "") +
                                            (_numTimesController.text.isEmpty &&
                                                    _numPillsController
                                                        .text.isEmpty
                                                ? "และ"
                                                : "") +
                                            (_numPillsController.text.isEmpty
                                                ? "ระบุจำนวนยา"
                                                : ""))
                                        : Text("Save change")),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () async {
                                          if (!_numTimesController
                                                  .text.isEmpty ||
                                              !_numPillsController
                                                  .text.isEmpty) {
                                            double numTimes = 1;

                                            try {
                                              numTimes = double.parse(
                                                  _numTimesController.text);
                                              print(numTimes);
                                            } catch (e) {
                                              // Handle the exception here
                                            }
                                            print(_numTimesController.text);
                                            print(_numPillsController.text);
                                            print(initialTime.format(context));
                                            print(endTime.format(context));
                                            double TimePerInterval = (((endTime
                                                                .hour
                                                                .toDouble() -
                                                            initialTime.hour
                                                                .toDouble()) *
                                                        60) +
                                                    (endTime.minute.toDouble() -
                                                        initialTime.minute
                                                            .toDouble())) /
                                                numTimes;
                                            print(TimePerInterval);
                                            await globalVariable.write(
                                                key: 'TimePerInterval',
                                                value:
                                                    TimePerInterval.toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientMainPage()),
                                            );
                                          } else {
                                            Navigator.of(context)
                                                .pop(DialogAction.cancel);
                                          }
                                        },
                                        child: Text('ตกลง'),
                                      ),
                                      FlatButton(
                                        onPressed: () => Navigator.of(context)
                                            .pop(DialogAction.cancel),
                                        child: Text('ยกเลิก'),
                                      )
                                    ],
                                  );
                                });
//Navigator.push(context, MaterialPageRoute(builder: (context) => usermainpage()),);
//Navigator.push(context, MaterialPageRoute(builder: (context) => firclockState()),);
//Navigator.push(context, MaterialPageRoute(builder: (context) => usermainpage()),);
                          },
                          child: const Text(
                            'CONFRIM/ตกลง',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(1.0)),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(1.0)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
