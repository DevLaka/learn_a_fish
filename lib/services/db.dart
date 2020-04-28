import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnafish/models/Fish.dart';

class dbService{
  // reference to the collection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');

  //add update fish
  Future updateFishData(String scName, String comName, String description, String kingdom, String cls, int len) async{
    return fishCollection.document().setData({
      'scName': scName,
      'comName': comName,
      'description': description,
      'kingdom': kingdom,
      'cls': cls,
      'len': len,
    });
  }

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

  //get fish stream
  Stream<List<Fish>> get fishStream{
    return fishCollection.snapshots()
        .map(_fishListFromSnapshot);
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