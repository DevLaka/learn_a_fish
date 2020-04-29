import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';

class register extends StatefulWidget {
  final Function redirect;
  register({this.redirect});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final services _authentication = services();

  //for validations
  final _key = GlobalKey<FormState>();
  String error = '';

  //text fields for  login
  String registeremail = '';
  String registerpassword = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Login'),
              onPressed: () {
                widget.redirect();
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 110.0, 15.0, 0.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter email' : null,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          onChanged: (val) {
                            setState(() => registeremail = val);
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 5
                            ? 'Enter a password more than 5 characters'
                            : null,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => registerpassword = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.lightBlue[400],
                          child: Text('Register'),
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              dynamic output = await _authentication.register(
                                  registeremail, registerpassword);
                              if (output == null) {
                                setState(
                                    () => error = 'registration unsuccessfull');
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
