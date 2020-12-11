import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petandur/Services/Penanaman.dart';

import '../../constants.dart';

class ArtikelDetail extends StatefulWidget {
  final DocumentSnapshot post;
  ArtikelDetail({this.post});
  
  

  @override
  _ArtikelDetailState createState() => _ArtikelDetailState();
}

class _ArtikelDetailState extends State<ArtikelDetail> {
  bool absorb = false;
  

  // Future getTanaman() async {
  //   var firestore = Firestore.instance;
  //   QuerySnapshot qn = await firestore
  //       .collection("tanaman/" + widget.post.documentID + "/Penanaman")
  //       .getDocuments();
  //   return qn.documents;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(
                          "tanaman/" + widget.post.documentID + "/penanaman")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if (querySnapshot.hasError) return Text("Some Error");

                    if (querySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final list = querySnapshot.data.documents;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (list[index].data.length == 2) {
                            return Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(list[index]["hari"]),
                                Text(list[index]["kegiatan1"]),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ));
                          } else if (list[index].data.length == 3) {
                            return Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(list[index]["hari"]),
                                Text(list[index]["kegiatan1"]),
                                Text(list[index]["kegiatan2"]),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ));
                          } else if (list[index].data.length == 4) {
                            return Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(list[index]["hari"]),
                                Text(list[index]["kegiatan1"]),
                                Text(list[index]["kegiatan2"]),
                                Text(list[index]["kegiatan3"]),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ));
                          } else if (list[index].data.length == 5) {
                            return Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(list[index]["hari"]),
                                Text(list[index]["kegiatan1"]),
                                Text(list[index]["kegiatan2"]),
                                Text(list[index]["kegiatan3"]),
                                Text(list[index]["kegiatan4"]),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ));
                          } else {
                            return Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(list[index]["hari"]),
                                Text(list[index]["kegiatan1"]),
                                Text(list[index]["kegiatan2"]),
                                Text(list[index]["kegiatan3"]),
                                Text(list[index]["kegiatan4"]),
                                Text(list[index]["kegiatan5"]),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ));
                          }
                        },
                        itemCount: list.length,
                      );
                    }
                  },
                )),

                // Text(user),
                AbsorbPointer(
                  absorbing: absorb,
                  child: ButtonTheme(
                    minWidth: size.width * 0.9,
                    height: 10.0,
                    child: RaisedButton(
                        child: Text(
                          "Tanam Sekarang",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        onPressed: () {
                          Penanaman.addData(widget.post.data["nama"]);
                        }),
                  ),
                ),
              ],
            ),

            // Container(
            //   padding: const EdgeInsets.only(top: 55.0),
            //   width: size.width * 0.9,
            //   height: size.height * 0.9,
            //   // color: Colors.green,
            //   child: FutureBuilder(
            //       future: getTanaman(),
            //       builder: (_, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(
            //             child: Text("Loading ..."),
            //           );
            //         } else {
            //           return ListView.builder(
            //               padding: EdgeInsets.only(top: 10),
            //               itemCount: snapshot.data.length,
            //               itemBuilder: (_, index) {
            //                 return ListTile(
            //                   leading: Text("sad"),
            //                   title: Text(snapshot.data[index].data["hari"]),
            //                   subtitle:
            //                       Text(snapshot.data[index].data["kategori"]),
            //                 );
            //               });
            //         }
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
