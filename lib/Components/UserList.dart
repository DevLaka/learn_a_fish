/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *                    
///                                                                                                                    *
///  @description this page is responsible for updating the user information and deleting the user account.initially   *
/// when registering the user application itself gives an user name and a bio and when user first goes to the          *
///  management page those values are displayed. after updating the values the updated username and bio will be shown. *
///  if a user needs to delete the account it also provided by this page                                               *
/// @author D.L.Kodagoda            IT17145008                                                                         *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _key = GlobalKey<FormState>();
  String error = '';

  //store current values
  String _username;
  String _bio;
  bool load = false;
  var email;

  //get current user
  getcurrentuser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userdata>(context) ??
        Userdata(
            uid: DateTime.now().toIso8601String(),
            username: 'user',
            bio: 'biobio');
    print(user.uid);
    getcurrentuser();
    return load
        ? Loading()
        : StreamBuilder<Userdata>(
            stream: UserDBService(uid: user.uid).userdata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Userdata data = snapshot.data;
                return Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                          child: Center(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage:
                                  AssetImage('assets/login-icon.png'),
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Text(
                          email.toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            initialValue: data.username,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: newTextInputDecoration.copyWith(
                                labelText: 'User Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white)),
                            onChanged: (val) {
                              setState(() => _username = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            initialValue: data.bio,
                            validator: (val) =>
                                val.isEmpty ? 'Enter your bio' : null,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: newTextInputDecoration.copyWith(
                                labelText: 'Bio',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white)),
                            onChanged: (val) {
                              setState(() => _bio = val);
                            }),
                        SizedBox(height: 20.0),
                        Container(
                          height: 50.0,
                          width: 250.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment(0.9, 0.0),
                              colors: [Colors.blueAccent, Colors.indigo],
                            ),
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              textColor: Colors.white,
                              color: Colors.transparent,
                              child: Text('Update',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  setState(() => load = true);
                                  dynamic output =
                                      await UserDBService(uid: user.uid)
                                          .updateUser(
                                              _username ?? data.username,
                                              _bio ?? data.bio);
                                  if (output == null) {
                                    setState(() {
                                      error = 'cannot update!';
                                      load = false;
                                    });
                                  }
                                }
                              }),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 50.0,
                          width: 250.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment(0.9, 0.0),
                              colors: [Colors.blueAccent, Colors.indigo],
                            ),
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              textColor: Colors.white,
                              color: Colors.transparent,
                              child: Text('Delete Account',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () async {
                                await UserDBService(uid: user.uid)
                                    .deleteuser()
                                    .then((_) {
                                  setState(() {
                                    load = true;
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  });
                                });
                              }),
                        ),
                      ],
                    ));
              } else {
                return Container();
              }
            });
  }
}
