import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Penanaman{
  static FirebaseAuth auth = FirebaseAuth.instance;

  static addData(String tanaman) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    DateTime waktuSkg = DateTime.now();
    final temp = DateFormat('yyyy-MM-dd').format(waktuSkg);
    var formated = DateTime.parse(temp+" 00:00:00");
    Timestamp waktu = Timestamp.fromDate(formated);



    Map<String,dynamic> data = {
      "idUser" : uid,
      "tanaman" : tanaman,
      "waktu" : waktu
    };

    CollectionReference collectionReference = Firestore.instance.collection('penanaman');
    collectionReference.add(data);
  }


}