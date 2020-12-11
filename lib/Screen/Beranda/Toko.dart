import 'package:flutter/material.dart';
import 'package:petandur/Services/Auth.dart';

import '../../constants.dart';
import '../Wrapper.dart';

class Toko extends StatefulWidget {
  @override
  _TokoState createState() => _TokoState();
}

class _TokoState extends State<Toko> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Toko'),
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