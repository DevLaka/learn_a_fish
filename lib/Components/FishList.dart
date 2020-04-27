import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> {

  @override
  Widget build(BuildContext context) {
    final fishes = Provider.of<QuerySnapshot>(context);

    for(var document in fishes.documents){
      print(document.data);
    }
    
    return Container(

    );
  }
}
