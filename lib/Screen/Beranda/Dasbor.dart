import 'package:flutter/material.dart';
import 'package:petandur/constants.dart';
import 'package:petandur/Screen/Wrapper.dart';
import 'package:petandur/Services/Auth.dart';

class Dasbor extends StatefulWidget {
  @override
  _DasborState createState() => _DasborState();
}

class _DasborState extends State<Dasbor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Dasbor'),
        actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await Auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Wrapper();
                }));
              },
            ),
          ],
      ),
    );
  }
}
