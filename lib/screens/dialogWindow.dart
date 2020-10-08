import 'package:flutter/material.dart';

class DialogWindow extends StatefulWidget {
  @override
  _DialogWindowState createState() => _DialogWindowState();
}

class _DialogWindowState extends State<DialogWindow> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Text("User on your (left/right) figure your dare"),
        FlatButton(onPressed: () {}, child: Text('OK'))
      ],
    );
  }
}
