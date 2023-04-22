import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itflowapp/constants/constants.dart';

class DataBaseController {
  static final _db = FirebaseFirestore.instance;

  static void setUser(String uid, Map<String, dynamic> info) async {
    try {
      _db.collection(kUserCollection).doc(uid).set(info);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  static void addAttribute(String uid, String name, dynamic value) {
    _db
        .collection(kUserCollection)
        .doc(uid)
        .set({name: value}, SetOptions(merge: true));
  }

  static Future<Map<String, dynamic>?> getUser(String uid) async {
    return (await _db.collection(kUserCollection).doc(uid).get()).data();
  }

  static Future<dynamic> getAttribute(String uid, String name) async {
    return (await _db.collection(kUserCollection).doc(uid).get()).data()?[name];
  }
}
