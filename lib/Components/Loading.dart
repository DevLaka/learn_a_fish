/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
/// @description this page is responsible for the loading widget . this is implemented by referring to the tutorial    *
///     https://www.youtube.com/watch?v=Vr_ahm78h_g    video series.                                                   *
///                                                                                                                    *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent[100],
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          size: 55.0,
        ),
      ),
    );
  }
}
