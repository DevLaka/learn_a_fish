import 'package:flutter/material.dart';
import 'package:learnafish/services/AuthenticationService.dart';

//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Home',
//          style: TextStyle(
//            color: Colors.black,
//          ),
//        ),
//        centerTitle: true,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.account_box,
//            ),
//            onPressed: () {
//              Navigator.pushNamed(context, '/userManagement');
//            },
//          ),
//        ],
//      ),
//      body: Center(
//        child: Text(
//          'press the upper right icon on the app bar to navigate to the user management'
//        ),
//      ),
//    );
//  }
//}

class Home extends StatelessWidget {

  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed:  () async {
                  await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
          ],
        ),
      )
    );
  }
}

