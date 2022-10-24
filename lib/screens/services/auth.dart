import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzler/models/user_in_app.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseuser
  UserInApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserInApp(uid: user.uid) : null;
  }
  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and link clicking
  Future signInWithEmailAndLink(String email) async {
    try {
      ActionCodeSettings acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
          url: 'https://youtest-96f4d.firebaseapp.com',
          // This must be true
          handleCodeInApp: true,
          iOSBundleId: 'com.example.ios',
          androidPackageName: 'com.example.quizzler',
          // installIfNotAvailable
          androidInstallApp: true,
          // minimumVersion
          androidMinimumVersion: '19');

      _auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: acs)
          .catchError((onError) => print('Error sending email verification $onError'))
          .then((value) => print('Successfully sent email verification'));

      // Confirm the link is a sign-in with email link.

      return null;


    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
  } catch(e) {
      print(e.toString());
      return null;
  }
}

  // auth change user stream
  Stream<UserInApp?> get user {
    return _auth.userChanges()
        //.map((User? user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }

  // register
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null && !user.emailVerified){
        await user.sendEmailVerification();
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}