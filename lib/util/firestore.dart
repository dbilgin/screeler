import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screeler/util/preferences.dart';
import 'dart:convert';

class FireStore {
  /// Saves [user] to Firestore.
  ///
  /// The new [user] is saved to Firestore if it
  /// doesn't already exist.
  /// This can be done after the login through Firebase
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

  /// Retrieves user-specific genres.
  ///
  /// The document of genres for the user are retrieved
  /// through the user's UID as [dynamic].
  static Future<dynamic> getUserGenres() async {
    return await Firestore.instance
        .collection('selected-genres')
        .document(await Preferences.getUid())
        .get()
        .then((DocumentSnapshot ds) {
      return ds.data;
    });
  }

  /// Adds or removes a user selected genre.
  ///
  /// Checks the current [userGenres], if it has the [id]
  /// removes it from Firestore, otherwise adds [id] and [name]
  /// to user's selected genres. Returns the updated [userGenres].
  static Future<Map<String, dynamic>> updateUserGenre(int id, String name,
      Map<String, dynamic> userGenres, bool isMovie) async {
    String key = (isMovie ? 'mov' : 'tv') + id.toString();

    if (userGenres == null) userGenres = new Map<String, dynamic>();

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
