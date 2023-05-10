import 'package:flutter/material.dart';

import '../../Patient/Main/patient_main_page.dart';

class StaffLastPage extends StatelessWidget {
  const StaffLastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Processing')),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(3.0)),
            Center(
                child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(3.0)),
              Text(" ข้อตกลงและเอกสารการยินยอมเกี่ยวกับแอป Pillbox "),
              Container(
                padding: EdgeInsets.all(50),
                child: Text(
                    """กรุณาอ่านข้อตกลงและเอกสารการยินยอมนี้อย่างรอบคอบก่อนใช้งานแอป Pillbox เพื่อให้คุณเข้าใจถึงข้อตกลงและข้อมูลส่วนตัวของคุณที่เกี่ยวข้อง

การเข้าใช้งานแอป
การใช้งานแอป Pillbox หมายความว่าคุณยอมรับและยินยอมตามข้อตกลงและเงื่อนไขการใช้งาน หากคุณไม่ยินยอมตามข้อตกลงและเงื่อนไขนี้ กรุณาอย่าใช้แอป

การจัดเก็บข้อมูลส่วนตัว
แอป Pillbox จะเก็บข้อมูลส่วนตัวของคุณ เช่น ชื่อ ที่อยู่อีเมล และข้อมูลการรับประทานยาที่คุณตั้งค่าในแอป เพื่อวัตถุประสงค์ในการส่งการแจ้งเตือนให้คุณตามตารางเวลาที่คุณกำหนด

การแชร์ข้อมูลกับบุคคลที่สาม
แอป Pillbox จะไม่แชร์ข้อมูลส่วนตัวของคุณกับบุคคลที่สาม ยกเว้นกรณีที่ได้รับความยินยอมจากคุณหรือตามกฎหมายที่บังคับใช้

การคุ้มครองข้อมูลส่วนตัว
เราจะใช้มาตรการความปลอดภัยที่เหมาะสมเพื่อป้องกันการเข้าถึง การเปิดเผย หรือการทำลายข้อมูลส่วนตัวของคุณโดยไม่ได้รับอนุญาต

การเปลี่ยนแปลงข้อตกลงและเงื่อนไข
เราสามารถแก้ไขข้อตกลงและเงื่อนไขนี้ได้ตลอดเวลา"""),
              ),
            ])),
            buildPatienSearchButton(context),
          ],
        ),
      ),
    );
  }

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
          'ยินยอม',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => PatientMainPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      );
}
