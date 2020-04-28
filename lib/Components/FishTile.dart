import 'package:flutter/material.dart';
import 'package:learnafish/models/Fish.dart';

class FishTile extends StatelessWidget {
  final Fish fish;
  FishTile({this.fish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(17.0, 7.0, 17.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pinkAccent,
          ),
          title: Text(fish.comName),
          subtitle: Text(fish.scName),
        ),
      ),
    );
  }
}
