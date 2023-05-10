import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pillbox_app/Page/Patient/Main/patient_main_page.dart';
import 'package:pillbox_app/Page/Staff/Login/staff_login_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  runApp(const Pillbox());
}

class Pillbox extends StatelessWidget {
  const Pillbox({Key? key}) : super(key: key);
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Secure Storage Demo',
      home: FutureBuilder<String?>(
        future: storage.read(key: 'patientData'),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // Key has a value, navigate to the main page
            Map<String, dynamic> decodedData =
                jsonDecode(snapshot.data.toString());
            String valueForKey1 =
                decodedData["Firstname"]; // will return "value1"
            print(valueForKey1.toString());
            return PatientMainPage();
          } else {
            // Key doesn't have a value, navigate to the register page
            return StaffLoginPage();
          }
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Page 1'),
  //     ),
  //     body: Center(
  //         child: TextButton(
  //       child: const Text('Click'),
  //       onPressed: () {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => const StaffApp()));
  //       },
  //     )),
  //   );
  // }
}
