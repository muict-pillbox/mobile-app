import 'package:flutter/material.dart';
import 'package:pillbox_app/Page/Patient/ColorBlindTest/patient_color_blind_testing_page.dart';

class PatientColorBlindMainPage extends StatefulWidget {
  @override
  State<PatientColorBlindMainPage> createState() =>
      PatientColorBlindMainPageState();
}

class PatientColorBlindMainPageState extends State<PatientColorBlindMainPage> {
  // const usermainpage({Key? key}) : super(key: key);
  void poppage(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    //String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";

    var now = DateTime.now();
    return MaterialApp(
      routes: {
        //"/second" : (context) => const SecondScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
            title: Text('ทดสอบอาการตาบอดสี'),
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
                Padding(padding: EdgeInsets.all(4.0)),
                Row(
                  children: [],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ขั้นตอนและคำชี้เเจงในการทำแบบทดสอบตาบอดสี',
                            style: TextStyle(fontSize: 25)),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Text(
                            '1. แบบทดสอบจะมีทั้งหมด 10 ข้อเมื่อกดเริ่มทำแบบทดสอบแล้วต้องทำแบบทดสอบให้ครบทุกข้อ'),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Text(
                            '2. อ่านตัวเลขจากรูปภาพทางซ้ายมือ จากนั้นเลือกกดปุ่มเบอร์ 0 - 9 ตามที่ท่านเห็น'),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Text(
                            '3. หากท่านไม่เห็นตัวเลขใด ๆ จากภาพทางซ้ายมือให้กดปุ่ม "ข้าม" '),
                        Padding(padding: EdgeInsets.all(8.0)),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
//ใส่รูปตรงนี้-----------------------------------------------------------------------------------------------------
                    Image(
                      image:
                          AssetImage('lib/Assets/ColorBlindTest/Coloreye.jpg'),
                      width: 220,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
//ใส่รูปตรงนี้-----------------------------------------------------------------------------------------------------
                  ],
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: [
                    SizedBox(
                      width: 260,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        minimumSize: Size(300, 80),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientColorBlindTestingPage(
                                    page: 0,
                                    userAnswer: [],
                                  )),
                        );
                      },
                      child: const Text(
                        'กดเพื่อเริ่มทำแบบทดสอบ',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
