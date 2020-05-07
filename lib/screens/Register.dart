import 'package:flutter/material.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/Components/Constants.dart';

class Register extends StatefulWidget {
  final Function redirect;
  Register({this.redirect});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Services _authentication = Services();

  //for validations
  final _key = GlobalKey<FormState>();
  String error = '';
  bool load = false;

  //text fields for  login
  String registeremail = '';
  String registerpassword = '';
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
            title: Text('REGISTER'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    widget.redirect();
                  })
            ],
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: AssetImage('assets/reg.png'),
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
                                  setState(() => registeremail = val);
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
                                labelText: "Pasword",
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                ),
                              ),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => registerpassword = val);
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
                                  child: Text('Register',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () async {
                                    if (_key.currentState.validate()) {
                                      setState(()=> load = true);
                                      dynamic output =
                                      await _authentication.register(
                                          registeremail, registerpassword);
                                      if (output == null) {
                                        setState(() =>
                                        error = 'registration unsuccessfull');
                                        load = false;
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style: TextStyle(fontSize: 15.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
