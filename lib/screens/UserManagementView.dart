/// ********************************************************************************************************************
/// This project was developed by the below-mentioned developers who are studying for                                  *
/// BSc (Hons) in Information Technology Specializing in Software Engineering at Sri Lanka Institute of                *
/// Information Technology. This project is developed as an assignment for the module Current Trends in                *
/// Software Engineering.                                                                                              *
/// Student Name             IT Number                                                                                 *
/// H.M.Y.L.W.Bandara       IT17250498                                                                                 *
/// D.L.Kodagoda            IT17145008                                                                                 *
///                                                                                                                    *
/// The intellectual and technical concepts contained herein are proprietary to its developers mentioned above         *
/// and Dissemination of this information or reproduction of this material is strictly forbidden unless                *
/// prior written permission is obtained from the above mentioned developers.                                          *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/UserList.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';
import 'package:provider/provider.dart';


class Usermanagementview extends StatelessWidget {
  //variables
  final services _HomeAuthentication = services();
  @override
  Widget build(BuildContext context) {
      final user = Provider.of<usermodel>(context);
    return StreamProvider<Userdata>.value(
      value: UserDBService(uid:user.userid).userdata,
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
