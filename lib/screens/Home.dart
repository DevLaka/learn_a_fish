/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This is the home screen. This page is wrapped with the Fish stream. The app bar contains navigation   *
/// for inserting a fish, user management page, and signOut. The body renders the FishList which is again modularized  *
/// inside the FisList.                                                                                                *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/FishDBService.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/Components/FishList.dart';

class Home extends StatelessWidget {
  final Services _homeAuthentication = Services();
  @override
  Widget build(BuildContext context) {
    /**
     * @description Wraps the home widget with the fish stream and make those
     * data accessible by the descendent widgets in the tree using Provider package
     */
    return StreamProvider<List<Fish>>.value(
      value: FishDBService().fishStream,
      // stack is used to render a background image for the entire screen including AppBar
      child: Stack(
        children: <Widget>[
          // background image
          Image.asset(
            'assets/background.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'HOME',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              // action buttons on the AppBar
              actions: <Widget>[
                IconButton(
                  // redirects to fish insert screen
                  icon: Icon(
                    Icons.add_box,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fishInsert');
                  },
                ),
                // redirects to user management
                IconButton(
                  icon: Icon(
                    Icons.people_outline,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/UserManagementview');
                  },
                ),
                // signOut Button
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await _homeAuthentication.signOut();
                  },
                ),
              ],
            ),
            // renders the FishList in the body
            body: FishList(),
          ),
        ],
      ),
    );
  }
}
