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
import 'package:learnafish/screens/UserManagementView.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/Login.dart';
import 'package:learnafish/screens/FishInsert.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/FishView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<usermodel>.value(
      value: services().user,
      child: MaterialApp(
        routes: {
          '/home': (context) => Home(),
          '/UserManagementview': (context) => Usermanagementview(),
          '/fishInsert': (context) => FishInsert(),
          '/fishView': (context) => FishView(),
          '/login': (context) => login(),
        },
        home: SplashScreen(
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.lightBlueAccent, Colors.indigo]),
          loadingText: Text(
            'Welcome to Nemo!!!',
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.lightBlueAccent,
              fontStyle: FontStyle.italic,
            ),
          ),
          seconds: 5,
          backgroundColor: Colors.blueAccent,
          image: Image.network(
              'https://i.giphy.com/media/sxXJgb4LCmJ44/giphy.gif'),
          loaderColor: Colors.white,
          photoSize: 150.0,
          navigateAfterSeconds: wrapper(),
        ),
      ),
    );
  }
}
