import 'package:firebase_auth/firebase_auth.dart';
import 'package:petandur/Screen/Beranda/Toko.dart';
import 'package:petandur/Screen/Beranda/Dasbor.dart';
import 'package:petandur/Screen/Beranda/Pasar.dart';
import 'package:petandur/Screen/Beranda/Artikel.dart';
import 'package:petandur/constants.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  final FirebaseUser user;
  Beranda(this.user);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dasbor(),
    Toko(),
    Pasar(),
    Artikel(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dasbor(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Colors.brown[50],
        // appBar: AppBar(
        //   title: Text(widget.user.uid),
        //   backgroundColor: Colors.brown[400],
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     FlatButton.icon(
        //       icon: Icon(Icons.person),
        //       label: Text('logout'),
        //       onPressed: () async {
        //         await Auth.signOut();
        //         Navigator.pushReplacement(context,
        //             MaterialPageRoute(builder: (context) {
        //           return Wrapper();
        //         }));
        //       },
        //     ),
        //   ],
        // ),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Dasbor(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.dashboard,
                            color:
                                currentTab == 0 ? kPrimaryColor : Colors.grey,
                          ),
                          Text(
                            'Dasbor',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? kPrimaryColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Toko(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            color:
                                currentTab == 1 ? kPrimaryColor : Colors.grey,
                          ),
                          Text(
                            'Toko',
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? kPrimaryColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Pasar(); // if user taps on this dashboard tab will be active
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_bag,
                            color:
                                currentTab == 2 ? kPrimaryColor : Colors.grey,
                          ),
                          Text(
                            'Pasar',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? kPrimaryColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Artikel(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.article,
                            color:
                                currentTab == 3 ? kPrimaryColor : Colors.grey,
                          ),
                          Text(
                            'Artikel',
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? kPrimaryColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
