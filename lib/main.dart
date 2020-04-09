import 'package:flutter/material.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/Login.dart';
import 'package:learnafish/screens/UserManagement.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Login(),
    '/home' : (context) => Home(),
    '/userManagement' : (context) => UserManagement(),
  },
));
