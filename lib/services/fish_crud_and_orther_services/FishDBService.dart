/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This class containes functions for inserting, updating, deleting, retrieving, and mapping             *
/// the QuerySnapshot to list of fish.                                                                                 *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnafish/models/Fish.dart';

class FishDBService{
  // reference to the fishCollection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');

  // ignore: slash_for_doc_comments
  /**
   * @description Inserting a fish document to fireStore database
   * @param id - document id
   * @param scName - scientific name
   * @param comName - common name
   * @param description - description about the fish
   * @param kingdom - fish kingdom
   * @param cls - fish class
   * @param len - fish length
   */
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

  // ignore: slash_for_doc_comments
  /**
   * @description Updating a fish document in fireStore database
   * @param id - document id
   * @param scName - scientific name
   * @param comName - common name
   * @param description - description about the fish
   * @param kingdom - fish kingdom
   * @param cls - fish class
   * @param len - fish length
   */
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

  // ignore: slash_for_doc_comments
  /**
   * @description Deleting fish document form fireStore database
   * @param id - document id
   */
  Future deleteSingleFishData(String id) async{
    return fishCollection.document(id).delete();
  }

  // ignore: slash_for_doc_comments
  /**
   * @description Getting fish stream
   * Reference - https://www.youtube.com/watch?v=sfA3NWDBPZ4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC
   */
  Stream<List<Fish>> get fishStream{
    return fishCollection.snapshots()
        .map(_fishListFromSnapshot);
  }

  // ignore: slash_for_doc_comments
  /**
   * @description Mapping the snapshot to list of Fishes
   * References - https://www.youtube.com/watch?v=sfA3NWDBPZ4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC
   */
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