import 'dart:math';

import 'package:flutter/material.dart';

import '../Main/patient_main_page.dart';

int call_number() {
  Random random = new Random();
  int randomNumber = random.nextInt(19) + 1;
  return randomNumber;
}

class PatientColorBlindTestingPage extends StatefulWidget {
  PatientColorBlindTestingPage(
      {Key? key, required this.page, required this.userAnswer})
      : super(key: key);

  late List<dynamic> userAnswer = [];
  final int page;

  @override
  State<PatientColorBlindTestingPage> createState() =>
      _PatientColorBlindTestingPageState();
}

class _PatientColorBlindTestingPageState
    extends State<PatientColorBlindTestingPage> {
  final String call_numbers = call_number().toString();

  int _getScore(List<dynamic> userAnswerList) {
    int score = 0;
    for (var element in userAnswerList) {
      if (int.parse(element["user"].toString()) ==
          (int.parse(element["question"].toString()) % 10)) {
        score += 1;
      }
    }
    return score;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int nextpage = widget.page + 1;
    final List<dynamic> answerList = widget.userAnswer;

    if (widget.page == 10) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Final Page'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: answerList.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isCorrect = false;
                  print(
                      "${answerList[index]["user"]} ${answerList[index]["question"]}");
                  if (int.parse(answerList[index]["user"].toString()) ==
                      (int.parse(answerList[index]["question"].toString()) %
                          10)) {
                    isCorrect = true;
                  }
                  print("${_getScore(widget.userAnswer)} $isCorrect");
                  return ListTile(
                    title: Text(
                        'Question ${index + 1}: ${int.parse(answerList[index]["user"].toString()) == 0 ? "ว่างเปล่า" : int.parse(answerList[index]["user"].toString())} | ${int.parse(answerList[index]["question"].toString()) % 10 == 0 ? "ว่างเปล่า" : int.parse(answerList[index]["question"].toString()) % 10}'),
                    subtitle: Text(isCorrect ? "Correct" : "Incorrect"),
                  );
                },
              ),
            ),
            // Add your button here
            Text("Total score: ${_getScore(widget.userAnswer)}"),
            ElevatedButton(
              onPressed: () {
                print(widget.userAnswer);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientMainPage()),
                );
              },
              child: Text('Done'),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Page ${widget.page}'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0)),
              Row(
                children: [
                  SizedBox(
                    width: 38.0,
                  ),
                  Image(
                    image: AssetImage('lib/Assets/ColorBlindTest/' +
                        'CB' +
                        call_numbers +
                        '.png'),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(padding: EdgeInsets.all(30.0)),
                  //numpad(),
                  Row(
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 1, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '1',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 4, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '4',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 7, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '7',
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 2, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '2',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 5, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '5',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 8, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '8',
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 3, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '3',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 6, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '6',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 9, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              '9',
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              minimumSize: Size(50, 50),
                            ),
                            onPressed: () {
                              widget.userAnswer
                                  .add({"user": 0, "question": call_numbers});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientColorBlindTestingPage(
                                          page: nextpage,
                                          userAnswer: widget.userAnswer,
                                        )),
                              );
                            },
                            child: const Text(
                              'ว่างเปล่า',
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(6.0)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
