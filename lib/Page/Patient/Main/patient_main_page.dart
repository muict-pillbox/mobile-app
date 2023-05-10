import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillbox_app/Page/Staff/Login/staff_login_page.dart';
import 'package:pillbox_app/Utility/OrientationFixer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Camera/patient_camera_page.dart';
import '../ColorBlindTest/patient_color_blind_test_main_page.dart';
import '../SideEffect/patient_main_side_effect_page.dart';
import '../Timesetting/patient_time_setting_page.dart';

class PatientMainPage extends StatefulWidget {
  PatientMainPage({Key? key}) : super(key: key);

  @override
  State<PatientMainPage> createState() => PatientMainPageState();
}

Future createAlertDialog(
    BuildContext context, String header, String textToDisplay,
    [Function()? callback, String? buttonText]) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(textToDisplay),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                callback?.call();
              },
              child: Text(buttonText ?? 'ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('cancel'),
            )
          ],
        );
      });
}

class PatientMainPageState extends State<PatientMainPage> {
  Duration duration = Duration();
  Timer? timer;
  bool isCountdown = true;
  late int globalTimeInterval = 0;
  late DateTime _startTime;
  late DateTime _endTime;
  late int timeNext = (_endTime.difference(_startTime).inSeconds);
  final globalVariable = const FlutterSecureStorage();
  late Future<String?> patientDataOnStorage;
  late Map<String, dynamic> patientData = {"Firstname": "", "Lastname": ""};
  late Map<String, dynamic> observertData = {"username": "", "CID": ""};

  Future<void> writeToStorage(String key, String value) async {
    await globalVariable.write(key: key, value: value);
  }

  Future<String?> readFromStorage(String key) async {
    String? value = await globalVariable.read(key: key);
    Map<String, dynamic> decodedData = jsonDecode(value.toString());
    return value;
  }

  Future<String?> readSingleFromStorage(String key) async {
    String? value = await globalVariable.read(key: key);
    print("This is value: $value");
    return value;
  }

  @override
  void initState() {
    super.initState();
    setStorageVariable();
    _startTime = DateTime.now();
    _endTime = _startTime.add(Duration(seconds: 60));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void setStorageVariable() {
    readFromStorage("patientData").then((value) {
      setState(() {
        patientData = jsonDecode(value.toString());
      });
    });

    readFromStorage("ObverserData").then((value) {
      setState(() {
        observertData = jsonDecode(value.toString());
        print(observertData);
      });
    });

    readSingleFromStorage("TimePerInterval").then((value) {
      print(value);
      setState(() {
        globalTimeInterval = (double.parse(value.toString()) * 60).toInt();
        print("globalTimeInterval: $globalTimeInterval");
        timer?.cancel();
        startTimer();
        reset(globalTimeInterval);
      });
    });
  }

  void reset(int time) {
    _startTime = DateTime.now();
    if (globalTimeInterval == 0) {
      _endTime = _startTime.add(Duration(seconds: time));
    } else {
      print("Time should be $globalTimeInterval");
      _endTime = _startTime.add(Duration(seconds: globalTimeInterval));
    }
    timeNext = (_endTime.difference(_startTime).inSeconds);
    print("${_startTime} ${_endTime} ${timeNext}");
    if (mounted) {
      if (isCountdown) {
        setState(() => duration = Duration(seconds: timeNext));
        ;
      } else {
        setState(() => duration = Duration());
      }
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        if (seconds < 0) {
          timer?.cancel();
          print('Time = 0');
          createAlertDialog(context, 'กินยาตอนนี้',
                  'ระบบจะนับการกินยาครั้งนี้ถือเป็นครั้งถัดไปทันที เพื่อความสะดวกของผู้ป่วย',
                  () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            ).then((result) {
              if (result != null && result) {
                startTimer();
              } else {
                reset(1000);
              }
            });
          }, 'ทานยา')
              .then((result) {
            if (result) {
              reset(1000);
            } else {
              reset(500);
              startTimer();
            }
          }).then((_) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientMainPage()),
                  ));
        } else {
          duration = Duration(seconds: seconds);
        }
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    //String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    var now = DateTime.now();

    return OrientationFixer(
        preferredOrientations: const [DeviceOrientation.landscapeLeft],
        child: Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'หน้าหลัก, ${patientData["Firstname"]} ${patientData["Lastname"]}',
              ),
              automaticallyImplyLeading: false,
              actions: [
                Row(
                  children: [
                    FlatButton(
                      onPressed: () {
                        // Show the popup
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Observer Info'),
                              content: Text(
                                  "CID: ${observertData["userAccount"]["CID"]}\nUsername: ${observertData["userAccount"]["username"]}"),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    // Close the popup
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );

                        // Wait for 5 seconds and close the popup
                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('Observer Info'),
                    ),
                    FlatButton(
                      onPressed: () {
                        // Show the popup
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Goto log in page'),
                              content: Text("Return to log in page?"),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    // Close the popup
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    await globalVariable
                                        .delete(key: 'patientData')
                                        .then((_) {
                                      timer?.cancel();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StaffLoginPage()),
                                      );
                                    });
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            );
                          },
                        );

                        // Wait for 5 seconds and close the popup
                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('[DEBUG]: Go to loin page'),
                    )
                  ],
                ),
              ],
            ),
            body: WillPopScope(
                onWillPop: _onWillPop,
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ทานยาครั้งต่อไปในอีก',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.all(20.0)),
                            buildTime(),
                            Padding(padding: EdgeInsets.all(40.0)),
                            Column(
                              children: [
                                Material(
                                  elevation: 9,
                                  borderRadius: BorderRadius.circular(10),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    //borderRadius: BorderRadius.circular(20),
                                    splashColor: Colors.black87,
                                    onTap: () {
                                      createAlertDialog(
                                          context,
                                          'Time Reminder',
                                          'Time reminder set up page', (() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TimeSetMed()),
                                        );
                                      }));
                                    },

                                    child: Ink.image(
                                      image: AssetImage('lib/Assets/Time.jpg'),
                                      width: 180,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Material(
                                  elevation: 9,
                                  borderRadius: BorderRadius.circular(10),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    //borderRadius: BorderRadius.circular(20),
                                    splashColor: Colors.black87,
                                    onTap: () {
                                      createAlertDialog(context, 'กินยาตอนนี้',
                                              'ระบบจะนับการกินยาครั้งนี้ถือเป็นครั้งถัดไปทันที เพื่อความสะดวกของผู้ป่วย',
                                              () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CameraPage()),
                                        ).then((result) {
                                          if (result != null && result) {
                                            startTimer();
                                          } else {
                                            reset(1000);
                                          }
                                        });
                                      }, 'ทานยา')
                                          .then((result) {
                                        if (result) {
                                          timer?.cancel();
                                        } else {}
                                      });
                                    },

                                    child: Ink.image(
                                      image:
                                          AssetImage('lib/Assets/medicine.jpg'),
                                      width: 180,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(20.0)),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.all(10.0)),
                            Material(
                              elevation: 9,
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                //borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.black87,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PatientSideEffectMainPage()),
                                  );
                                },

                                child: Ink.image(
                                  image: AssetImage('lib/Assets/Affect.jpg'),
                                  width: 370,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5.0)),
                            Material(
                              elevation: 9,
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                //borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.black87,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PatientColorBlindMainPage()),
                                  );
                                },

                                child: Ink.image(
                                  image:
                                      AssetImage('lib/Assets/ColorBlind.jpg'),
                                  width: 370,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'ชั่วโมง'),
        const SizedBox(
          width: 8,
        ),
        buildTimeCard(time: minutes, header: 'นาที'),
        const SizedBox(
          width: 8,
        ),
        buildTimeCard(time: seconds, header: 'วินาที'),
      ],
    );

/*
    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 80),
    );
*/
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 130,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(header),
        ],
      );
}
