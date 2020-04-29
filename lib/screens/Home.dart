import 'package:flutter/material.dart';
import 'package:learnafish/authentication_services/AuthenticationService.dart';

class Home extends StatelessWidget {
  //variables
  final services _homeAuthentication = services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _homeAuthentication.SignOut();
            },
          )
        ],
        
      ),
      body: Center(
        child: Text(
          'press the upper right icon on the app bar to navigate to the user management'
        ),
      ),
    );
  }
}
