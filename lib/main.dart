import 'package:flutter/material.dart';
import 'package:learnafish/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{ 
  @override
  Widget build(BuildContext context) {
    return StreamProvider<usermodel>.value(
        value: services().user,
          child: MaterialApp(
        home: wrapper(),
      ),
    );
  }

}
