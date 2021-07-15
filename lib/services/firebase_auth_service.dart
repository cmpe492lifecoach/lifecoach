import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  // ignore: missing_return
  Future<User> currentUser() async{
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    }catch(e) {
      print("Error Current User" +e.toString());
      return null;

    }


  }

  User _userFromFirebase(FirebaseUser user) { // bu method firebase user ı normal user a dönüştürür.
    if(user == null)
      return null;
    return User(userID: user.uid, email: user.email);
  }

  @override
  Future<User> signInAnonyously() async{
    try{
    AuthResult result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
    }catch(e){
     print("Error Anonymous Sign In" +e.toString());
     return null;
    }
  }

  @override
  Future<bool> signOut() async{
    try {
      final _googleSignIn = GoogleSignIn();
       await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    }catch(e){
      print("Error Sign Out" +e.toString());
      return false;
    }
  }

  @override
  Future<User> signInWithGoogle() async{
   GoogleSignIn _googleSignIn = GoogleSignIn();
   GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
   if(_googleUser != null) {
     GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
     if(_googleAuth.idToken != null && _googleAuth.accessToken != null) {
       AuthResult result = await _firebaseAuth.signInWithCredential(
         GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken)
       );
       FirebaseUser _user = result.user;
       return _userFromFirebase(_user);
     }
     else {
       return null;
     }
   }
    else {
      return null;
   }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
    }catch(e){
      print("Error Sign In" +e.toString());
      return null;
    }
  }

  @override
  Future<User> createWithEmailAndPassword(String email, String password) async{

      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);

  }

}