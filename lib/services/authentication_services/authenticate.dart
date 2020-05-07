/// ********************************************************************************************************************
/// This project was developed by the below-mentioned developers who are studying for                                  *
/// BSc (Hons) in Information Technology Specializing in Software Engineering at Sri Lanka Institute of                *
/// Information Technology. This project is developed as an assignment for the module Current Trends in                *
/// Software Engineering.                                                                                              *
/// Student Name             IT Number                                                                                 *
/// H.M.Y.L.W.Bandara       IT17250498                                                                                 *
/// D.L.Kodagoda            IT17145008                                                                                 *
///                                                                                                                    *
/// The intellectual and technical concepts contained herein are proprietary to its developers mentioned above         *
/// and Dissemination of this information or reproduction of this material is strictly forbidden unless                *
/// prior written permission is obtained from the above mentioned developers.                                          *
///                                                                                                                    *
///*********************************************************************************************************************

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