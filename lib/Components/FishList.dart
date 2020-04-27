import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/models/Fish.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> {

  @override
  Widget build(BuildContext context) {
    final fishes = Provider.of<List<Fish>>(context);

    fishes.forEach((fish){
      print(fish.cls);
      print(fish.family);
      print(fish.phylum);
      print(fish.comName);
      print(fish.description);
      print(fish.kingdom);
      print(fish.scName);
    });
    
    return Container(

    );
  }
}
