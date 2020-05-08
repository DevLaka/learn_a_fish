/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///  @ description this page is reponsible for creating a new user and giving initial user naem an bio. the            *
/// login function and logout function is also provided by this page.                                                  *
/// reference : https://www.youtube.com/watch?v=Vr_ahm78h_g video series.                                              *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';


class Services{

final FirebaseAuth _userAuthInstance = FirebaseAuth.instance;

 Usermodel _firebaseuser(FirebaseUser userfirebase)
 {
    return userfirebase != null ? Usermodel(userid: userfirebase.uid) : null;
 }
  //change user stream
  Stream<Usermodel>get user{
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
      await UserDBService(uid: reguser.uid).updateUser('Initial user name', ' Initial Bio');

      return  _firebaseuser(reguser);
    }catch(e)
    {
      print(e.toString());
      print('error');
      return null;
    }
  }

  //signout
  Future signOut() async{
    try{
      return await _userAuthInstance.signOut();
    }catch(e){
      return null;
    }
  }
}