import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillbox_app/Page/Patient/Main/patient_main_page.dart';

class PatientAddSideEffectMainPage extends StatefulWidget {
  @override
  State<PatientAddSideEffectMainPage> createState() =>
      PatientAddSideEffectMainPageState();
}

class PatientAddSideEffectMainPageState
    extends State<PatientAddSideEffectMainPage> {
// const usermainpage({Key? key}) : super(key: key);
  late String inputtext;

  Future pickImage() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }

  TextEditingController nameController = TextEditingController();

  void poppage(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //"/second" : (context) => const SecondScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
            title: Text('ส่งผลข้างเคียงเพิ่มเติม'),
            leading: GestureDetector(
              onTap: () {
                poppage(context);
              },
              child: Icon(Icons.home),
            )),
        //title: Text('ทดสอบอาการตาบอดสี'),

        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: new Container(
                        width: 650.0,
                        height: 120.0,
                        decoration: new BoxDecoration(
                          color: Colors.black12,
                        ),
                        child: TextField(
                          /*
                          onChanged: (value){

                          },
                          */
                          controller: nameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 55),
                            border: OutlineInputBorder(),
                            // fillColor: Colors.green,
                            labelText:
                                'บันทึกประว้ติการทานยาและผลค้างเคียงที่นี่',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                    ),
                    RaisedButton(
                      onPressed: () => pickImage()
                          .then((value) => Navigator.of(context).pop()),
                      child: Text('เพิ่มรูปภาพ'),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    RaisedButton(
                      onPressed: () {
                        print(inputtext);
                        openDialog(inputtext);
                        // print(nameController.text);
                        // inputtext = nameController.text;
                        // saveAdditionalEffectResult().writeCounter(inputtext);
                      },
                      child: Text('บันทึก'),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ยกเลิก'),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(35.0)),
                Row(
                  children: [
                    SizedBox(
                      width: 3.0,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
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

  Future openDialog(text) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text("อาการ: $text"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //print(symptomsAndScore);
                Navigator.pop(context, false);
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                //print(symptomsAndScore);
                Navigator.pop(context, true);
                endDialog();
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      });

  Future endDialog() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('บันทึกผลลัพธ์สำเร็จ!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                //print(symptomsAndScore);
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
}
