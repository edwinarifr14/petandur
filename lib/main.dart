
import 'package:petandur/Screen/Wrapper.dart';
import 'package:petandur/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }


class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return StreamProvider.value(
      value: Auth.user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()
      ),
      
    );
  }
}