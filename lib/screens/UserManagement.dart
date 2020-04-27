import 'package:flutter/material.dart';

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Management',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
