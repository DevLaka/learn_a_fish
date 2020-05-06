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
import 'package:learnafish/models/Fish.dart';

class dbService{
  // reference to the collection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');

  //insert a fish document to fireStore database
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

  //update a fish document to fireStore database
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

  //delete fish document form fireStore database
  Future deleteSingleFishData(String id) async{
    return fishCollection.document(id).delete();
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