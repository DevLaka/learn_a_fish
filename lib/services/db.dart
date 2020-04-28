import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnafish/models/Fish.dart';

class dbService{
  // reference to the collection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');

  //add update fish
  Future updateFishData(String scName, String comName, String description, String kingdom, String phylum, String family, String cls) async{
    return fishCollection.document().setData({
      'scName': scName,
      'comName': comName,
      'description': description,
      'kingdom': kingdom,
      'phylum': phylum,
      'family': family,
      'cls': cls
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
        scName: document.data['scName'] ?? '',
        comName: document.data['comName'] ?? '',
        description: document.data['description'] ?? '',
        kingdom: document.data['kingdom'] ?? '',
        phylum: document.data['phylum'] ?? '',
        family: document.data['family'] ?? '',
        cls: document.data['cls'] ?? '',
      );
    }).toList();
  }
}