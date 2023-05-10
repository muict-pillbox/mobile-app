import 'package:flutter/material.dart';

import '../Last/staff_last_page.dart';

class PatientConfigPage extends StatelessWidget {
  const PatientConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Config')),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(3.0)),
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
          'Staff last page',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StaffLastPage(),
          ));
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      );
}
