import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/Components/FishList.dart';

class Home extends StatelessWidget {
  //variables
  final services _homeAuthentication = services();
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
            FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _homeAuthentication.SignOut();
            },
          )
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
