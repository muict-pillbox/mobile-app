import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FileCard extends StatelessWidget {
  final String filePath;

  const FileCard({Key? key, required this.filePath}) : super(key: key);

  Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    String size =
        ('${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}');
    return size;
  }

  Future<String?> uploadVideo(filename) async {
    String serverIp = "http://192.168.1.34:3500/upload";
    var request = http.MultipartRequest('POST', Uri.parse(serverIp));
    request.files.add(await http.MultipartFile.fromPath('video', filename));
    print("Upload $filename to $serverIp");
    var res = await request.send();
    print(" Response: ${res.reasonPhrase}");
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    Future endDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('อัพโหลดไฟล์...'),
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
        });
    Future openDialog(String path, String name, date) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('อัพโหลดไฟล์ $date | $name ?'),
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
                  // print(path);
                  try {
                    uploadVideo(path);
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pop(context, true);
                  endDialog();
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        });

    print("File in card: $filePath");
    if (filePath.isNotEmpty) {
      String name = filePath.split('/').last.split('.').first;
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(name));
      // print(name);
      var dateFormated = DateFormat('dd/MM/yyyy, HH:mm').format(date);
      return FutureBuilder(
          future: getFileSize(filePath, 2),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              String? data = snapshot.data;
              return ListTile(
                title: Text("$dateFormated | $name"),
                subtitle: Text("$filePath \n $data"),
                trailing: IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: (() {
                    openDialog(filePath, name, dateFormated);
                  }),
                ),
              );
            } else {
              return Container();
            }
          });
    }
    return const Text("Error occur");
  }
}
