import 'package:flutter/material.dart';
import 'package:petandur/Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petandur/Screen/Artikel/ArtikelDetail.dart';

import '../../constants.dart';
import '../Wrapper.dart';

class Artikel extends StatefulWidget {
  @override
  _ArtikelState createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  String _valkategori;
  List _listkategori = ["Semua", "Buah", "Sayur"];

  Future getTanaman() async {
    var firestore = Firestore.instance;
    if (_valkategori == null || _valkategori == "Semua") {
      QuerySnapshot qn = await firestore.collection("tanaman")
      .getDocuments();
      return qn.documents;
    } else if(_valkategori == "Buah"){
      QuerySnapshot qn = await firestore.collection("tanaman").where("kategori", isEqualTo: "Buah").getDocuments();
      return qn.documents;
    } else{
      QuerySnapshot qn = await firestore.collection("tanaman").where("kategori", isEqualTo: "Sayuran").getDocuments();
      return qn.documents;
    }
  }

  navigateArtikelDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtikelDetail(post : post,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Artikel'),
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
      body: Container(
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0,),
            child: Container(
              child: DropdownButton(
                hint: Text("Kategori"),
                value: _valkategori,
                items: _listkategori.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valkategori = value;
                  });
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 55.0),
            child: FutureBuilder(
                future: getTanaman(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading ..."),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 55,
                                      minHeight: 55,
                                      maxWidth: 55,
                                      minWidth: 55,
                                    ),
                                    child: Image.network(
                                        snapshot.data[index].data["gambar1"],
                                        fit: BoxFit.cover))),
                            title: Text(snapshot.data[index].data["nama"]),
                            subtitle: Text(snapshot.data[index].data["kategori"]),
                            onTap: () => navigateArtikelDetail(snapshot.data[index]),
                          );
                        });
                  }
                }),
          ),
        ]),
      ),
    );
  }
}
