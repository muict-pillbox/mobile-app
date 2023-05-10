import 'package:flutter/material.dart';

class StaffRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ลงทะเบียน')),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(3),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(padding: EdgeInsets.all(6)),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(6)),
                Container(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // fillColor: Colors.green,
                      labelText: 'อีเมล',
                      hintText: 'example@email.com',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(4)),
                Container(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // fillColor: Colors.green,
                      labelText: 'ID',
                      hintText: 'example_ID',
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(4)),
                Container(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // fillColor: Colors.green,
                      labelText: 'รหัสผ่าน',
                      hintText: '***********',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(4)),
                Container(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // fillColor: Colors.green,
                      labelText: 'ชื่อ',
                      hintText: 'ระบุชื่อ',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(4)),
                Container(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // fillColor: Colors.green,
                      labelText: 'นามสกุล',
                      hintText: 'ระบุนามสกุล',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
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
                'ลงทะเบียน',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {},
            )
          ],
        )),
      )),
    );
  }
}
