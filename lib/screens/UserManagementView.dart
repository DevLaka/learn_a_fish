/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description this page is responsible for updating the user information.                                           *
///  if a user needs to delete the account it also provided by this page                                               *
///                                                                                                                    *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

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
    
      final user = Provider.of<Usermodel>(context);
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
