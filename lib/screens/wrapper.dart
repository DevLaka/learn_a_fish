import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/services/authentication_services/authenticate.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    final userprovider = Provider.of<usermodel>(context);

    if(userprovider == null){
      return Authenticate();
    }else {
      return Home();
   }
  }
}