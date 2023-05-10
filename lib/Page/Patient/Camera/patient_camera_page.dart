import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:pillbox_app/Utility/OrientationFixer.dart';
import '../Main/patient_main_page.dart';
import 'screens/camera_screen.dart';
import 'screens/file_explorer.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool pressed = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
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

  @override
  Widget build(BuildContext context) {
    return OrientationFixer(
        preferredOrientations: const [DeviceOrientation.portraitUp],
        child: Scaffold(
          appBar: AppBar(
            title: Text("Camera Test"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                // onPressed: () => Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         OrientationFixer(child: const PatientMainPage()),
                //   ),
                // ),
                onPressed: () => Navigator.pop(context, true)),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                ),
                Center(
                  child: SizedBox(
                    width:
                        300, // Container child widget will get this width value
                    height:
                        600, // Container child widget will get this height value
                    child: CameraScreen(),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => FileExplorer(),
                        ),
                      );
                    },
                    child: Text("File Explorer"))
              ],
            ),
          ),
        ));
  }
}
