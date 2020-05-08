/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///  @ description this page is responsible for showing the home page if the user is logged in or other wise           *
/// it renders the login/regster page.                                                                                 *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/screens/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Usermodel>(context);

    if (userProvider == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
