import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screeler/util/preferences.dart';
import 'dart:convert';

class FireStore {
  // A new [User] is saved to Firestore
  // This can be done after the login through Firebase
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

  // Retrieves user-specific genres
  // The document of genres for the user are retrieved
  // through the user's UID
  static Future<dynamic> getUserGenres() async {
    return await Firestore.instance
        .collection('selected-genres')
        .document(await Preferences.getUid())
        .get()
        .then((DocumentSnapshot ds) {
      return ds.data;
    });
  }

  /// A group of *members*.
  ///
  /// When a user selects a new genre
  /// this will be used to add it to the firestore
  ///
  /// @param T the type of a member in this group.
  /// @property name the name of this group.
  /// @constructor Creates an empty group.
  static Future<Map<String, dynamic>> updateUserGenre(int id, String name,
      Map<String, dynamic> userGenres, bool isMovie) async {
    String key = (isMovie ? 'mov' : 'tv') + id.toString();

    if (userGenres[key] == null)
      userGenres.putIfAbsent(key, () => name);
    else
      userGenres.remove(key);

    Firestore.instance
        .collection('selected-genres')
        .document(await Preferences.getUid())
        .setData(userGenres);
  }
}
