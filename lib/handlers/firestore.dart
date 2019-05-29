import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screeler/handlers/preferences.dart';

class FireStore {
  static saveUserToFireStore(FirebaseUser user) async {
    var userDocument =
        await Firestore.instance.collection('users').document(user.uid).get();
    if (!userDocument.exists) {
      Firestore.instance.collection('users').document(user.uid).setData({
        "email": user.email,
        "photoUrl": user.photoUrl,
        "displayName": user.displayName,
        "uid": user.uid
      });
    }
  }

  static Future<dynamic> getUserGenres() async {
    return await Firestore.instance
        .collection('selected-genres')
        .document(await Preferences.getUid())
        .get()
        .then((DocumentSnapshot ds) {
      return ds.data;
    });
  }

  static addUserGenre(int id, String name) async {
    Firestore.instance
        .collection('selected-genres')
        .document(await Preferences.getUid())
        .setData({'id': id, 'name': name});
  }
}