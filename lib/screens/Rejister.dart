import 'package:flutter/material.dart';
import 'package:learnafish/services/AuthenticationService.dart';
import 'package:learnafish/components/constants.dart';
import 'package:learnafish/components/Loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthenticationService _auth = AuthenticationService();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String email = "";
  String  password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        title: Text('Register in to Nemo'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (value) => value.isEmpty ? "Enter an email" : null,
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (value) => value.length < 6 ? "Need at leat 6 characters" : null,
                decoration: textInputDecoration.copyWith(hintText: "Passwrod"),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassowrd(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Please supply valid eamil and password';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 15.0,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
