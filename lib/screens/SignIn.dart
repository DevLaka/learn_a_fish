import 'package:flutter/material.dart';
import 'package:learnafish/components/Loading.dart';
import 'package:learnafish/services/AuthenticationService.dart';
import 'package:learnafish/components/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
        title: Text('Sign in to Nemo'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Regitster'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//        child: RaisedButton(
//          child: Text('Sing in anon'),
//          onPressed: () async {
//            dynamic result  = await _auth.anonymousSignIn();
//            if(result == null){
//              print('Error signin in');
//            }else{
//              print('Signin in');
//              print(result.userId);
//            }
//          },
//        ),
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
                'SignIn',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if(_formkey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                dynamic result = await _auth.signInWithEmailAndPassowrd(email, password);
                  if(result == null){
                    setState(() {
                      error = 'sign in failed';
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
