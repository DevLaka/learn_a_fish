/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///  @description this page is responsible for providing the data variables in the user collection.                    *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

class Usermodel {
  final String userid;

  Usermodel({this.userid});
}

//user management
class Userdata {
  final String uid;
  final String username;
  final String bio;

  Userdata({this.uid, this.username, this.bio});
}
