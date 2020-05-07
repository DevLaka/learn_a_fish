import 'package:flutter/material.dart';
import 'package:learnafish/screens/Register.dart';
import 'package:learnafish/screens/Login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //statement
  bool value = true;

  void redirect(){
    setState(() => value = !value);
  }
  @override
  Widget build(BuildContext context) {
    if (value)
    {
      return Login(redirect: redirect);
    }
    else
    {
      return Register(redirect: redirect);
    }
  }
}