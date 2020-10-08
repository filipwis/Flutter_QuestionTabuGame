import 'package:flutter/material.dart';
import 'package:flutter_partyQuestionsApp/screens/createUserScreen.dart';
import 'package:flutter_partyQuestionsApp/screens/dialogWindow.dart';
import 'package:flutter_partyQuestionsApp/screens/gamePreferencesScreen.dart';
import 'package:flutter_partyQuestionsApp/screens/homeScreen.dart';
import 'package:flutter_partyQuestionsApp/screens/questionScreen.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/preferences': (context) => GamePreferences(),
          '/user': (context) => CreateUser(),
          '/question': (context) => Question(),
          '/dialog': (context) => DialogWindow(),
        },
      ),
    );
