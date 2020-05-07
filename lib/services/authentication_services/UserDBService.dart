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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnafish/models/user.dart';

class UserDBService{
  // reference to the user collection
  final CollectionReference userCollection = Firestore.instance.collection('User');

  //variables for user management
  final String uid;
  UserDBService({this.uid});

  //add update user
  Future updateUser(String username,String bio) async{
    return await userCollection.document(uid).setData({
      'username' : username,
      'bio' : bio,
    });

  }
  //delete record
  Future deleteusernew() async{
    bool result = false;
    return await  userCollection.document(uid).delete();
  }

  //delete user record
  Future deleteuser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await user.delete();
  }
  //get user stream
  Stream<Userdata> get userdata{
    return userCollection.document(uid).snapshots()
        .map(_snapshotdata);
  }

  //snapshot form user data
  Userdata _snapshotdata(DocumentSnapshot snap){
    return Userdata(
      uid: uid,
      username: snap.data['username'],
      bio: snap.data['bio'],
    );
  }

}