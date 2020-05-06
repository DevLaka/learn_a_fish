import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/models/user.dart';

class dbService{
  // reference to the collection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');
  final CollectionReference userCollection = Firestore.instance.collection('User');
  
  //variables for user management
  final String uid;
 
  dbService({this.uid});
  //add update user
  Future updateUser(String username,String bio) async{
    return await userCollection.document(uid).setData({
      'username' : username,
      'bio' : bio,
    });

  }
  //delte record
  Future deleteusernew() async{
    bool result = false;
  return await  userCollection.document(uid).delete();
  }
 //delte record
  Future deleteuser() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return await user.delete();
  }



  //insert a fish document to firestore database
  Future addFishData(String id, String scName, String comName, String description, String kingdom, String cls, int len) async{
    return fishCollection.document(id).setData({
      'scName': scName,
      'comName': comName,
      'description': description,
      'kingdom': kingdom,
      'cls': cls,
      'len': len,
    });
  }

  //update a fish document to firestore database
  Future updateSingleFishData(String id, String scName, String comName, String description, String kingdom, String cls, int len) async{
    return fishCollection.document(id).setData({
      'scName': scName,
      'comName': comName,
      'description': description,
      'kingdom': kingdom,
      'cls': cls,
      'len': len,
    });
  }

  //delete fish document form firestore database
  Future deleteSingleFishData(String id) async{
    return fishCollection.document(id).delete();
  }

  //get fish stream
  Stream<List<Fish>> get fishStream{
    return fishCollection.snapshots()
        .map(_fishListFromSnapshot);
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


  //fish list from snapshot
  List<Fish> _fishListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((document) {
      return Fish(
        docID: document.documentID,
        scName: document.data['scName'] ?? '',
        comName: document.data['comName'] ?? '',
        description: document.data['description'] ?? '',
        kingdom: document.data['kingdom'] ?? '',
        cls: document.data['cls'] ?? '',
        len: document.data['len'] ?? '',
      );
    }).toList();
  }
}