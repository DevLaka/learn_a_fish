import 'package:flutter/material.dart';
import 'package:learnafish/screens/UserManagement.dart';
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

    void _showusermanagement(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal:60.0),
          child: usermanagement(),
        );
      });
    }
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
                Icons.add_box,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/fishInsert');
              },
              
            ),
            FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(''),
            onPressed: () async{
              await _homeAuthentication.SignOut();
            },
          ),
          FlatButton.icon(
            onPressed: () =>_showusermanagement(),
             icon: Icon(Icons.settings), 
             label: Text(''))
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
