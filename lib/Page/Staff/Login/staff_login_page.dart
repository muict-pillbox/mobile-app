import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillbox_app/Page/Staff/Register/staff_register_page.dart';
import 'package:pillbox_app/Page/Staff/Setting/setting_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../Utility/API_fetch.dart';
import '../../../Utility/OrientationFixer.dart';

class StaffLoginPage extends StatefulWidget {
  @override
  State<StaffLoginPage> createState() => _StaffLoginPageState();
}

class _StaffLoginPageState extends State<StaffLoginPage> {
  final _formKeyScreen1 = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final globalVariable = const FlutterSecureStorage();

  final String _query = r'''
    query Login($input: LoginInput) {
  login(input: $input) {
    userInfo {
      userRole
      Firstname
      Lastname
    }
    userAccount {
      CID
      username
    }
  }
}
  ''';
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationFixer(
        preferredOrientations: const [DeviceOrientation.portraitUp],
        child: Scaffold(
            appBar: AppBar(
              title: Text('Staff Control login'),
            ),
            body: Center(
                child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'กรุณาเข้าสู่ระบบ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  Form(
                      key: _formKeyScreen1,
                      child: Column(
                        children: <Widget>[
                          buildLogo(),
                          SizedBox(height: 32),
                          buildUsernameField(),
                          SizedBox(height: 16),
                          buildPasswordField(),
                          SizedBox(height: 32),
                          buildLoginButton(context),
                          SizedBox(height: 8),
                          buildRegisterButton(context),
                        ],
                      ))
                ],
              ),
            ))));
  }

  Future<GraphQLResult<Map<String, dynamic>>> _getQueryResult(
      input_query) async {
    final result =
        await getGraphQLData(_query, input_query as Map<String, dynamic>);
    return result;
  }

  Widget buildLogo() {
    return Image(
      image: AssetImage('lib/Assets/User_icon.png'),
      width: 140,
      height: 140,
    );
  }

  Widget buildUsernameField() => TextFormField(
        controller: _userController,
        autocorrect: true,
        textCapitalization: TextCapitalization.words,
        enableSuggestions: false,
        validator: (value) {},
        cursorColor: Colors.grey,
        style: TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.person_outline_rounded),
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onSaved: (username) {},
        textInputAction: TextInputAction.next,
      );

  Widget buildPasswordField() => TextFormField(
        controller: _passController,
        validator: (value) {},
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.lock_rounded),
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        obscureText: true,
        onSaved: (password) {},
        textInputAction: TextInputAction.done,
      );

  Widget buildLoginButton(BuildContext context) => ElevatedButton(
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
          'LOGIN',
          style: TextStyle(fontSize: 16),
        ),
        // onPressed: () {
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const SettingPage(),
        //   ));
        // }
        onPressed: () async {
          if (_userController.text.isNotEmpty &&
              _passController.text.isNotEmpty) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
            try {
              final login = await _getQueryResult({
                "input": {
                  "username": _userController.text.toString(),
                  "passwordHased": _passController.text.toString()
                }
              });
              // print(login.data!['login']['CID']);
              await globalVariable.delete(key: 'patientData');
              await globalVariable.write(
                  key: 'ObverserData',
                  value:
                      jsonEncode(login.data!['login'] as Map<String, dynamic>));
              String? value = await globalVariable.read(key: 'ObverserData');
              print("Observer data: $value");
              Navigator.pop(context);
              if (login.data != null) {
                // print(login.data!['login']['CID']);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Welcome, ${login.data!['login']['userAccount']['username']} !',
                    ),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
                // wait for 1 second
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
                // FocusScope.of(context).requestFocus(new FocusNode());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Incorrect Username or Password'),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              }
            } catch (e) {
              print(e);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error logging in'),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please log in'),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
      );

  Widget buildRegisterButton(BuildContext context) => ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.fromHeight(50),
          backgroundColor: Colors.white,
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'REGISTER',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => StaffRegisterPage(),
          ))
              .then((_) {
            _formKeyScreen1.currentState?.reset();
            FocusScope.of(context).requestFocus(new FocusNode());
          });
        },
      );
}
