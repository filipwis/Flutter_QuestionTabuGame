import 'package:flutter/material.dart';
import 'package:flutter_partyQuestionsApp/screens/questionScreen.dart';
import 'package:flutter_partyQuestionsApp/services/game.dart';
import 'package:flutter_partyQuestionsApp/services/user.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _userForm = GlobalKey<FormState>();
  int userCount = 1;
  List<User> users = List();
  String name;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Game game = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey[200],
            child: FractionallySizedBox(
              heightFactor: 0.6,
              widthFactor: 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'User $userCount',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Image.asset(
                    'assets/images/avatar.png',
                    width: 120.0,
                    height: 120.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Form(
                      key: _userForm,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Container(
                            child: TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold)),
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                }),
                          ))),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_right,
                          color: userCount == game.users
                              ? Colors.grey
                              : Colors.blue,
                        ),
                        onPressed: userCount != game.users
                            ? () {
                                if (_userForm.currentState.validate()) {
                                  User user = new User();
                                  user.name = name;
                                  setState(() {
                                    users.add(user);
                                    userCount++;
                                    _controller.clear();
                                  });
                                }
                              }
                            : null,
                        iconSize: 80.0,
                      )),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: userCount == game.users
              ? () async {
                  if (_userForm.currentState.validate()) {
                    User user = new User();
                    user.name = name;
                    setState(() {
                      users.add(user);
                    });

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Question(),
                            settings: RouteSettings(
                                arguments: {'users': users, 'game': game})),
                        ModalRoute.withName("/"));
                  }
                }
              : null,
          child: Icon(Icons.done),
          backgroundColor: userCount != game.users ? Colors.grey : Colors.blue,
        ));
  }
}
