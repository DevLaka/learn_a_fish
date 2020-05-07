/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This class gets access to the List of fish sent through fish stream using Provider and renders        *
/// fishTile for each fish object                                                                                      *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
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
    // Gets access to the List of fish sent through fish stream using Provider
    final fishes = Provider.of<List<Fish>>(context) ?? [];

    // Building the list view and returning FishTile for each fish of fishes list
    return ListView.builder(
      itemCount: fishes.length,
      itemBuilder: (context, index) {
        return FishTile(fish: fishes[index]);
      },
    );
  }
}
