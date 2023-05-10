import 'package:flutter/material.dart';
import 'package:pillbox_app/Page/Patient/SideEffect/patient_add_side_effect_page.dart';

import '../Main/patient_main_page.dart';

class PatientSideEffectMainPage extends StatefulWidget {
  @override
  State<PatientSideEffectMainPage> createState() =>
      PatientSideEffectMainPageState();
}

class PatientSideEffectMainPageState extends State<PatientSideEffectMainPage> {
  late String symptomsAndScore;
  //List<List<String>> symthomAndScore = [];
  static int CountPainScoreLv = 0;

  void poppage(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('ผลข้างเคียง'),
            leading: GestureDetector(
              onTap: () {
                poppage(context);
              },
              child: Icon(Icons.home),
            )),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                    ),
                    Padding(padding: EdgeInsets.all(1.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'คันตามผิวหนัง';
                        openlvselect();
                      },
                      child: const Text(
                        'คันตามผิวหนัง',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ตัว-หน้าบวม';
                        openlvselect();
                      },
                      child: const Text('ตัว-หน้าบวม'),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ชาปลายมือ-เท้า';
                        openlvselect();

                        //opendialog();
                      },
                      child: const Text('ชาปลายมือ-เท้า'),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'คลื่นใส้อาเจียน';
                        openlvselect();
                      },
                      child: const Text('คลื่นใส้อาเจียน'),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ปัสสาวะสีส้ม';
                        openlvselect();
                      },
                      child: const Text(
                        'ปัสสาวะสีส้ม',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ปวดท้อง';
                        openlvselect();
                      },
                      child: const Text('ปวดท้อง'),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ตัว-ตาเหลือง';
                        openlvselect();
                      },
                      child: const Text('ตัว-ตาเหลือง'),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ผื่นคัน';
                        openlvselect();
                      },
                      child: const Text('ผื่นคัน'),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'การมองเห็นผิดปกติ';
                        openlvselect();
                      },
                      child: const Text(
                        'การมองเห็นผิดปกติ',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        minimumSize: Size(165, 60),
                      ),
                      onPressed: () {
                        symptomsAndScore = 'ปัสสาวะออกน้อย';
                        openlvselect();
                      },
                      child: const Text('ปัสสาวะออกน้อย'),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        minimumSize: Size(347, 60),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientAddSideEffectMainPage()),
                        );
                      },
                      child: const Text('ผลข้างเคียงเพิ่มเติม'),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(32.9)),
                Row(
                  children: [
                    SizedBox(
                      width: 3.0,
                    ),
                    Padding(padding: EdgeInsets.all(8.2)),
                    //nav()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog(level) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('บันทึกผลลัพธ์สำเร็จ!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print("Symtomp: $symptomsAndScore  Level: $level");
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      }).then((_) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientMainPage()),
      ));

  Future openlvselect() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('กรุณาเลือกระดับความรุนเเรงของอาการ' + symptomsAndScore),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                openDialog(3);
                // saveEffectResult().writeCounter('high', symptomsAndScore);
              },
              child: Text('มาก'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                openDialog(2);
                //symptomsAndScore.add('med');
                // saveEffectResult().writeCounter('medium', symptomsAndScore);
              },
              child: Text('ปานกลาง'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                openDialog(1);
                //symptomsAndScore.add('low');
                // saveEffectResult().writeCounter('low', symptomsAndScore);
              },
              child: Text('น้อย'),
            ),
          ],
        );
      });
}
