import 'package:firebase_auth/firebase_auth.dart';
import 'package:petandur/Screen/Auth/LoginPage.dart';
import 'package:petandur/Screen/Beranda/Beranda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseUser user = Provider.of<FirebaseUser>(context);
    // print(user);
    
    // return either the Home or Authenticate widget
    return (user == null) ? LoginPage() : Beranda(user);
    
  }
}