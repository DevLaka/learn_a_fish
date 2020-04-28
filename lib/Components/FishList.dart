import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/Components/FishTile.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> {

  @override
  Widget build(BuildContext context) {
    final fishes = Provider.of<List<Fish>>(context) ?? [];

    fishes.forEach((fish){
      print(fish.docID);
      print(fish.cls);
      print(fish.family);
      print(fish.phylum);
      print(fish.comName);
      print(fish.description);
      print(fish.kingdom);
      print(fish.scName);
      print(fish.len);
    });
    
    return ListView.builder(
      itemCount: fishes.length,
      itemBuilder: (context, index) {
        return FishTile(fish: fishes[index]);
      },
    );
  }
}
