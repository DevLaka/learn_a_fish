import 'package:flutter/material.dart';
import 'package:learnafish/Components/UserList.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';
import 'package:provider/provider.dart';


class Usermanagementview extends StatelessWidget {
  //variables
  final Services _HomeAuthentication = Services();
  @override
  Widget build(BuildContext context) {
    
      final user = Provider.of<usermodel>(context);
    return StreamProvider<Userdata>.value(
      value: UserDBService(uid:user.userid).userdata,
      child: Container(
        decoration: BoxDecoration(
            image : DecorationImage(
              image : AssetImage('assets/background.jpg'),
              fit : BoxFit.cover,
            ),
          ),

        child: Scaffold(
            backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'User Management',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
         
        body: UserList(),  
          
        ),
      ),
    );
  }
}
