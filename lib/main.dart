/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This page contains all the routes and the wrapper class. The wrapper class is the single entry point  *
/// of the application. The wrapper class is wrapped with the splash screen widget. To render the splash screen        *
/// "splashscreeen" dart package is used.                                                                              *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
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

void main() => runApp(LearnAFish());

class LearnAFish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * @description Provides the access to the user stream data and pass those
     * data to the descendent widgets using Provider package
     */
    return StreamProvider<usermodel>.value(
      value: Services().user,
      child: MaterialApp(
        // all the routes of the application
        routes: {
          '/home': (context) => Home(),
          '/UserManagementview': (context) => Usermanagementview(),
          '/fishInsert': (context) => FishInsert(),
          '/fishView': (context) => FishView(),
          '/login': (context) => Login(),
        },
        // rendering the SplashScreen
        home: SplashScreen(
          // gradient background is given to the SplashScreen
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
          // setting the timeout for the splashScreen
          seconds: 3,
          // Using a GIF for a splashScreen
          image: Image.network(
              'https://i.giphy.com/media/sxXJgb4LCmJ44/giphy.gif'),
          loaderColor: Colors.white,
          photoSize: 150.0,
          // Navigating to wrapper class after the timeout is over
          navigateAfterSeconds: Wrapper(),
        ),
      ),
    );
  }
}
