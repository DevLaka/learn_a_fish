import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
