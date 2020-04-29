import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/UserManagement.dart';
import 'package:learnafish/screens/FishInsert.dart';
import 'screens/FishView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{ 
  @override
  Widget build(BuildContext context) {
    return StreamProvider<usermodel>.value(
        value: services().user,
          child: MaterialApp(
          routes: {
            '/home' : (context) => Home(),
            '/userManagement' : (context) => UserManagement(),
            '/fishInsert' : (context) => FishInsert(),
            '/fishView' : (context) => FishView(),
        },
        home: wrapper(),
      ),
    );
  }

}

