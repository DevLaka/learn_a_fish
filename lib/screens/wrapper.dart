import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:learnafish/screens/Register.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    final userprovider = Provider.of<usermodel>(context);

    if(userprovider == null){
      return register();
    }else
   {
      return Home();
   }
  }
}