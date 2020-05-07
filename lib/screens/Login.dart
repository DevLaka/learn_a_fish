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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';

class Login extends StatefulWidget {
  final Function redirect;
  Login({this.redirect});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Services _authentication = Services();
  //for validations
  final _key = GlobalKey<FormState>();
  String error = '';
  bool load = false;

    //text fields for  login
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {

    return load ? Loading() : Stack(
      children: <Widget>[
        Image.asset(
          'assets/background.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('LOGIN'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.person_add),
                  onPressed: () {
                    widget.redirect();
                  })
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.jpg'),
                        fit: BoxFit.cover,
                      ))),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: AssetImage('assets/login-icon.png'),
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                                validator: (val) =>
                                val.isEmpty ? 'Enter email' : null,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: newTextInputDecoration.copyWith(
                                  labelText: "E-Mail",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (val) => val.length < 5
                                  ? 'Enter a password more than 5 characters'
                                  : null,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: newTextInputDecoration.copyWith(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                ),
                              ),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
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
                                  child: Text('Sign In',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () async {
                                    if (_key.currentState.validate()) {
                                      setState(()=> load = true);
                                      dynamic output = await _authentication
                                          .login(email, password);
                                      if (output == null) {
                                        setState(() => error =
                                        'incorret password or email !');
                                        load = false;
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                              TextStyle(fontSize: 15.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
