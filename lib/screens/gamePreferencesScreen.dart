import 'package:flutter/material.dart';
import 'package:flutter_partyQuestionsApp/services/game.dart';

class GamePreferences extends StatefulWidget {
  @override
  _GamePreferencesState createState() => _GamePreferencesState();
}

class _GamePreferencesState extends State<GamePreferences> {
  final _gamePreferences = GlobalKey<FormState>();
  Game game = new Game();
  int selectedRadio = 10;
  int users = 0;

  void _setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          key: _gamePreferences,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 170.0, bottom: 6.0),
                child: Text(
                  'Users count:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 160.0,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    game.users = int.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Users count cannot be empty.';
                    }
                    if (int.parse(value) < 2) {
                      return 'Minimum 2 users.';
                    }
                    return null;
                  },
                ),
              ),
              Divider(height: 60.0),
              Text(
                'Rounds count:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Radio(
                          value: 10,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            _setSelectedRadio(val);
                          }),
                      Text('10'),
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                          value: 20,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            _setSelectedRadio(val);
                          }),
                      Text('20'),
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                          value: 30,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            _setSelectedRadio(val);
                          }),
                      Text('30'),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: FlatButton(
                  onPressed: () {
                    if (_gamePreferences.currentState.validate()) {
                      game.rounds = selectedRadio;
                      Navigator.pushNamed(context, '/user', arguments: game);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                ),
              )
            ],
          )),
    );
  }
}
