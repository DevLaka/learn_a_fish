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