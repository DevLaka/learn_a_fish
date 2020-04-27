import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnafish/models/User.dart';

class AuthenticationService{

  final FirebaseAuth _authObj = FirebaseAuth.instance;

  //create user object base on firebase user
  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(userId: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _authObj.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebase(user));
      .map(_userFromFirebase);
  }
  
  
  //sign in anon
  Future anonymousSignIn() async {
    try{
      AuthResult response = await _authObj.signInAnonymously();
      FirebaseUser user = response.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassowrd(String email, String passwrod) async {
    try{
      AuthResult result = await _authObj.signInWithEmailAndPassword(email: email, password: passwrod);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //register with email and password
  Future registerWithEmailAndPassowrd(String email, String passwrod) async {
    try{
      AuthResult result = await _authObj.createUserWithEmailAndPassword(email: email, password: passwrod);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _authObj.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}