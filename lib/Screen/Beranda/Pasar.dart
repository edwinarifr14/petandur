import 'package:flutter/material.dart';
import 'package:petandur/Services/Auth.dart';

import '../../constants.dart';
import '../Wrapper.dart';

class Pasar extends StatefulWidget {
  @override
  _PasarState createState() => _PasarState();
}

class _PasarState extends State<Pasar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Pasar'),
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