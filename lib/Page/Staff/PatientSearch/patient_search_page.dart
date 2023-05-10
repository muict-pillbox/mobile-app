import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../Utility/API_fetch.dart';
import '../PatientConfig/patient_config_page.dart';

class PatientSearchPage extends StatefulWidget {
  const PatientSearchPage({Key? key}) : super(key: key);

  @override
  State<PatientSearchPage> createState() => _PatientSearchPageState();
}

class _PatientSearchPageState extends State<PatientSearchPage> {
  late bool _showData;
  final _cidController = TextEditingController();
  final globalVariable = const FlutterSecureStorage();

  final String _query = r'''
    query User($cid: String!) {
    Userinfo(CID: $cid) {
        CID
        Firstname
        Lastname
        Gender
        dob
        telephone
        tambon
        amphoe
        province
        homeAddress
        email
        userRole
      }
    }
  ''';

  @override
  initState() {
    super.initState();
    _showData = false;
  }

  @override
  void dispose() {
    _cidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Search')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              maxLength: 13,
              controller: _cidController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'รหัสบัตรประจำตัวประชาชน',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => PatientConfigPage(),
                //   ),
                // );
                await globalVariable.delete(key: 'patientData');
                final cid = _cidController.text;
                if (_showData) {
                  setState(() {
                    _showData = false;
                  });
                }
                if (cid.length == 13) {
                  setState(() {
                    _showData = true;
                  });
                  FocusScope.of(context).unfocus();
                } else {
                  // Show an error message if the CID is not valid
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Invalid CID'),
                      content: Text('Please enter a 13-digit CID'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(290, 50),
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 32),
            if (_showData)
              Expanded(
                child: FutureBuilder<GraphQLResult<Map<String, dynamic>>>(
                  future:
                      _getQueryResult({"cid": _cidController.text.toString()}),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      print(snapshot.data);
                      final data =
                          snapshot.data!.data!['Userinfo'] as List<dynamic>;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final userInfo = data[index] as Map<String, dynamic>;
                          return ListTile(
                            title: Text(
                                '${userInfo['Firstname']} ${userInfo['Lastname']}'),
                            subtitle: Text(userInfo['CID']),
                            onTap: () {
                              List<String> userInfoText = [
                                "CID: ${userInfo['CID']}",
                                "ชื่อ-สกุล: ${userInfo['Firstname']} ${userInfo['Lastname']}",
                                "เพศ: ${userInfo['Gender']}",
                                "ปี/เดือน/วัน เกิด: ${userInfo['dob'].substring(0, 10)}",
                                "อายุ: ${(DateTime.now().difference(DateTime.parse(userInfo['dob'].substring(0, 10))).inDays / 365).floor()}",
                                "ที่อยู่: ${userInfo['tambon'] == null ? '' : "${userInfo['tambon']}, "}${userInfo['amphoe'] == null ? '' : "${userInfo['amphoe']}, "}${userInfo['province'] == null ? '' : "${userInfo['province']}, "}${userInfo['homeAddress'] == null ? '' : "${userInfo['homeAddress']}"}"
                              ];
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("ยืนยันข้อมูลผู้ป่วย ?"),
                                    content: Text(userInfoText.join("\n")),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("Yes"),
                                        onPressed: () async {
                                          await globalVariable.write(
                                              key: 'patientData',
                                              value: jsonEncode(userInfo));
                                          print(await globalVariable.read(
                                              key: 'patientData'));
                                          Navigator.of(context)
                                              .pop(); // Close the dialog box
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PatientConfigPage(),
                                            ),
                                          ); // Proceed to the next page
                                        },
                                      ),
                                      TextButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog box
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<GraphQLResult<Map<String, dynamic>>> _getQueryResult(
      input_query) async {
    final result =
        await getGraphQLData(_query, input_query as Map<String, dynamic>);
    return result;
  }
}
