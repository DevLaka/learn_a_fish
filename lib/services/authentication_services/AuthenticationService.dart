/// ********************************************************************************************************************
/// This project was developed by the below-mentioned developers who are studying for                                  *
/// BSc (Hons) in Information Technology Specializing in Software Engineering at Sri Lanka Institute of                *
/// Information Technology. This project is developed as an assignment for the module Current Trends in                *
/// Software Engineering.                                                                                              *
/// Student Name             IT Number                                                                                 *
/// H.M.Y.L.W.Bandara       IT17250498                                                                                 *
/// D.L.Kodagoda            IT17145008                                                                                 *
///                                                                                                                    *
/// The intellectual and technical concepts contained herein are proprietary to its developers mentioned above         *
/// and Dissemination of this information or reproduction of this material is strictly forbidden unless                *
/// prior written permission is obtained from the above mentioned developers.                                          *
///                                                                                                                    *
///*********************************************************************************************************************

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