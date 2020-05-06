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
          '/UserManagementview' : (context) => Usermanagementview(),
          '/fishInsert': (context) => FishInsert(),
          '/fishView': (context) => FishView(),
          '/login' : (context) => login(),
        },
        home: SplashScreen(
            gradientBackground: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlueAccent, Colors.indigo]),
            loadingText: Text('Welcome to Nemo!!!',
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
