

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await _db
        .collection("Users")
        .doc(userData.username)
        .set(userData.toJson())
        .onError((error, stackTrace) => throw (error.toString()));
  }

  Future<bool> retrieveUser(String username) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").doc(username).get();
    if(snapshot.data()!=null){
      return true;
    }
    return false;
  }
}
