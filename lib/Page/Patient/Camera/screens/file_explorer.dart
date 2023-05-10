import 'dart:io';

import 'widget/file_card.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../patient_camera_page.dart';

class FileExplorer extends StatefulWidget {
  @override
  State<FileExplorer> createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  List<File> allFileList = [];
  List<String> filePath = [];

  Future<List<String>> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    List<Map<int, dynamic>> fileNames = [];

    filePath.clear();

    fileList.forEach((file) {
      if (file.path.contains('.mp4')) {
        filePath.add(file.path);
      }
    });

    if (filePath != []) {
      print(filePath);
      return filePath;
    }

    return [];
  }

  Future<String?> uploadImage(filename) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.1.34:3500/upload"));
    request.files.add(await http.MultipartFile.fromPath('video', filename));
    var res = await request.send();
    print(" Response: ${res.reasonPhrase}");
    return res.reasonPhrase;
  }

  @override
  void initState() {
    super.initState();
  }

  getAllFile() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
        print(file.path);
      }
    });
    // if (filePath.isNotEmpty) {
    //   print("Uploading $filePath");
    //   // uploadImage(filePath);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CameraPage(),
            ),
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getFilePath(),
          builder: ((context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              print(data?.length);
              int? dataLenght = data?.length;
              return ListView.builder(
                itemCount: dataLenght,
                itemBuilder: ((context, int index) {
                  return FileCard(filePath: data![index]);
                }),
              );
            }
          }),
        ),
      ),
    );
  }
}
