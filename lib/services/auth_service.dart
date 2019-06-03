import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../util/firestore.dart';
import '../util/preferences.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signs in to Google with Firebase.
  ///
  /// Returns a [FirebaseUser] from the Google sign in.
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  /// Starts the sign in process with Firebase.
  signIn() {
    _handleSignIn()
        .then((FirebaseUser user) => {FireStore.saveUserToFireStore(user), Preferences.saveUid(user.uid)})
        .catchError((e) => {print(e)});
  }
}
