import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/UserList.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';


class Usermanagementview extends StatelessWidget {
  //variables
  final services _HomeAuthentication = services();
  @override
  Widget build(BuildContext context) {
      final user = Provider.of<usermodel>(context);
    return StreamProvider<Userdata>.value(
      value: dbService(uid:user.userid).userdata,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Management',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
       
      body: Center(
            child: UserList()  
            ),
        
      ),
    );
  }
}
