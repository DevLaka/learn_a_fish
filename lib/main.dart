import 'package:flutter/material.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/Login.dart';
import 'package:learnafish/screens/Redirector.dart';
import 'package:learnafish/screens/UserManagement.dart';
import 'package:learnafish/services/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthenticationService().user,
        child: MaterialApp(
        //  routes: {
        //    '/': (context) => Login(),
        //    '/home' : (context) => Home(),
        //    '/userManagement' : (context) => UserManagement(),
        //  },
          home: Redirector(),
        ),
    );
  }
}


