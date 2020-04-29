import 'package:flutter/material.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/db.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/Components/FishList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Fish>>.value(
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
            IconButton(
              icon: Icon(
                Icons.add_box,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/fishInsert');
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blue-background.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: FishList()
        ),
      ),
    );
  }
}
