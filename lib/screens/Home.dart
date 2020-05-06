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
          backgroundColor: Colors.indigo,
          title: Text(
            'HOME',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_box,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/fishInsert');
              },
              
            ),
            IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _homeAuthentication.SignOut();
            },
          ),
           //navigate to user management  
          IconButton(
              icon: Icon(
                Icons.people_outline,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/UserManagementview');
              },
              
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            )),
            child: FishList()),
      ),
    );
  }
}
