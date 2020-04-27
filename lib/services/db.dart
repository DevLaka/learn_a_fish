import 'package:cloud_firestore/cloud_firestore.dart';

class dbService{

  // reference to the collection
  final CollectionReference fishCollection = Firestore.instance.collection('fishCollection');

  Future updateFishData(String scNmae, String comName, String description, String kingdom, String phylum, String family, String cls) async{
    return fishCollection.document().setData({
      'scName': scNmae,
      'comName': comName,
      'description': description,
      'kingdom': kingdom,
      'phylum': phylum,
      'family': family,
      'cls': cls
    });
  }
}