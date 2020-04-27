import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/services/db.dart';
import 'package:learnafish/services/db.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnafish/Components/FishList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: dbService().fishStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_box,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/userManagement');
              },
            ),
          ],
        ),
//        body: Center(
//          child: RaisedButton(
//            onPressed: () async{
//              try{
//                await dbService().updateFishData('sceintific name a', 'common name a', 'descirption a', 'kingdom a', ' a', 'family a', 'cls a');
//              }catch(e){
//
//              }
//
//            },
//            child: Text(
//              'Add',
//            ),
//            color: Colors.lightBlue,
//          ),
//        ),
      body: FishList(),
      ),
    );
  }
}
