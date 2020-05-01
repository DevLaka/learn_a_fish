import 'package:flutter/material.dart';
import 'package:learnafish/screens/Register.dart';
import 'package:learnafish/screens/Login.dart';

class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  //statement
  bool value = true;

  void redirect(){
    setState(() => value = !value);
  }
  @override
  Widget build(BuildContext context) {
    if (value)
    {
      return login(redirect: redirect);
    }
    else
    {
      return register(redirect: redirect);
    }
//    return register();
  }
}