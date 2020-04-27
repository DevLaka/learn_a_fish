import'package:flutter/material.dart';
import 'package:learnafish/screens/Authenticate.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/SignIn.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/models/User.dart';

class Redirector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return Authenticate or Home widget after checking the users login state
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}
