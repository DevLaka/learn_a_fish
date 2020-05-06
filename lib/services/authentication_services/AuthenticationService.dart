import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';

class services{

final FirebaseAuth _userAuthInstance = FirebaseAuth.instance;

 usermodel _firebaseuser(FirebaseUser userfirebase)
 {
    return userfirebase != null ? usermodel(userid: userfirebase.uid) : null;
 }
  //change user stream
  Stream<usermodel>get user{
    return _userAuthInstance.onAuthStateChanged.map( _firebaseuser);
  }
  //login
   Future login(String email , String pwd) async 
  {
    
    try{
      AuthResult rslt = await _userAuthInstance.signInWithEmailAndPassword(email: email, password: pwd);
      FirebaseUser reguser = rslt.user;
      return  _firebaseuser(reguser);
    }catch(e)
    {
      print(e.toString());
      print('error');
      return null;
    }
  }

  // register
  Future register(String email , String pwd) async 
  {
    
    try{
      AuthResult rslt = await _userAuthInstance.createUserWithEmailAndPassword(email: email, password: pwd);
      FirebaseUser reguser = rslt.user;
      //new document for extra information on user 
      await UserDBService(uid: reguser.uid).updateUser('username', '-');

      return  _firebaseuser(reguser);
    }catch(e)
    {
      print(e.toString());
      print('error');
      return null;
    }
  }

  //signout
  Future SignOut() async{
    try{
      return await _userAuthInstance.signOut();
    }catch(e){
      return null;
    }
  }
}