import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_partyQuestionsApp/screens/gamePreferencesScreen.dart';
import 'package:flutter_partyQuestionsApp/services/game.dart';
import 'package:flutter_partyQuestionsApp/services/questions.dart';
import 'package:flutter_partyQuestionsApp/services/user.dart';
import 'dart:math';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<User> users = List();
  Game game;
  int round = 1;
  int currentUser = 0;
  User currentPlayer = new User();
  List<Questions> questionsList = List();
  String question = "";

  String randomUser() {
    int _random = new Random().nextInt(2);
    if (_random == 0) {
      return 'prawej';
    } else {
      return 'lewej';
    }
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/questions.json');
    List<dynamic> questionsRaw = json.decode(jsonString);
    setState(() {
      for (int i = 0; i < questionsRaw.length; i++) {
        questionsList.add(Questions(questions: questionsRaw[i]['question']));
      }
    });
  }

  String questionMaker() {
    if (questionsList.isNotEmpty) {
      int _questionIndex = new Random().nextInt(questionsList.length);
      setState(() {
        question = questionsList[_questionIndex].questions;
        questionsList.removeAt(_questionIndex);
      });
    }
    return question;
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    users = data['users'];
    game = data['game'];
    currentPlayer = users[currentUser];
    return Scaffold(
        body: round <= game.rounds
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Text(
                      'Round: ' + round.toString(),
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          currentPlayer.name.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () async {
                        if (currentPlayer.items > 0) {
                          await showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text(
                                    'Użytkownik ${currentPlayer.name[0].toUpperCase() + currentPlayer.name.substring(1)} użył TABU - nie odpowiada na pytanie'),
                                content: Image.asset(
                                  'assets/images/item.png',
                                  height: 70.0,
                                  width: 70.0,
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  )
                                ],
                              ));
                          if (currentUser < game.users - 1) {
                            setState(() {
                              currentPlayer.items--;
                              currentPlayer.itemsList.removeLast();
                              currentPlayer = users[currentUser];
                              currentUser++;
                            });
                          } else {
                            setState(() {
                              currentPlayer.items--;
                              currentPlayer.itemsList.removeLast();
                              currentPlayer = users[currentUser];
                              currentUser = 0;
                              round++;
                            });
                          }
                        } else {
                          null;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(child: currentPlayer.drawTabu()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        color: Colors.grey[100],
                        child: Text(
                          questionMaker(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Text(
                        //   'Wolałbyś/wolałabyś być z osobą, która jest wyjątkowo inteligenta, ale mało atrakcyjna, czy osobą, która jest wyjątkowo atrakcyjna, ale mało inteligentna?',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 150.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 30.0),
                          onPressed: () {
                            if (game.users == 1) {
                              setState(() {
                                round++;
                              });
                            } else if (currentUser < game.users - 1) {
                              setState(() {
                                currentPlayer = users[currentUser];
                                currentUser++;
                              });
                            } else {
                              setState(() {
                                currentPlayer = users[currentUser];
                                currentUser = 0;
                                round++;
                              });
                            }
                          },
                          child: Text(
                            'Answered',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.green,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 38.0),
                          onPressed: () async {
                            String punisher = randomUser();
                            await showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: game.users == 2
                                      ? Text('Przeciwnik wymyśla zadanie')
                                      : Text(
                                          'Użytkownik po $punisher wymyśla zadanie',
                                          textAlign: TextAlign.center,
                                        ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "OK",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    )
                                  ],
                                ));
                            if (game.users == 1) {
                              setState(() {
                                round++;
                              });
                            } else if (currentUser < game.users - 1) {
                              setState(() {
                                currentPlayer = users[currentUser];
                                currentUser++;
                              });
                            } else {
                              setState(() {
                                currentPlayer = users[currentUser];
                                currentUser = 0;
                                round++;
                              });
                            }
                          },
                          child: Text(
                            'Funked',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'The game is over',
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 25.0),
                    ),
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePreferences(),
                          ),
                          ModalRoute.withName("/"));
                    },
                    icon: Icon(
                      Icons.refresh,
                    ),
                    label: Text(
                      'Once Again',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                  )
                ],
              ));
  }
}
