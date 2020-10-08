import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Text(
              'Tabu',
              style: TextStyle(fontSize: 60.0, fontFamily: 'Montserrat'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 145.0,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/preferences');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.play_arrow,
                    size: 40.0,
                  ),
                  Text(
                    'START',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          )
        ],
      ),
    ));
  }
}
