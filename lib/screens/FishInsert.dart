import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FishInsert extends StatefulWidget {
  @override
  _FishInsertState createState() => _FishInsertState();
}

class _FishInsertState extends State<FishInsert> {
  final _formkey = GlobalKey<FormState>();
  final List<String> classes = ['cls a', 'cls b', 'cls c'];

  String commonName = "";
  String scientificName = "";
  String family = "";
  String kingdom = "";
  String phylum = "";
  String description = "";
  String error = "";
  String cls = "cls a";
  int len = 1;

  @override
  Widget build(BuildContext context) {
    Future<bool> _showSuccessPopUp() {
      return Alert(
          context: context,
          title: "Insert Sucessful",
          desc: "Your Fish is sucessfully inserted to NEMO",
          image: Image.asset("assets/success-alert.png"),
          buttons: [
            DialogButton(
              child: Text('Add another fish'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            DialogButton(
              child: Text('View Fish List'),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ]).show();
    }

    Future<bool> _showErrorPopUp(Error e) {
      return Alert(
          context: context,
          title: "Insert UnSucessful",
          desc: "Insertion Faile! Nemo feels Sorry!",
          image: Image.asset("assets/error-alert.png"),
          buttons: [
            DialogButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]).show();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add a Fish'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/blue-background.jpg'),
                fit: BoxFit.cover,
              )),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: "Common Name"),
                        onChanged: (value) {
                          setState(() {
                            commonName = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: "Scientific Name"),
                        onChanged: (value) {
                          setState(() {
                            scientificName = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        color: Colors.white,
                        child: Slider(
                          label: "Length",
                          value: (len).toDouble(),
                          min: 1,
                          max: 100,
                          divisions: 50,
                          onChanged: (value) {
                            setState(() {
                              len = value.round();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: cls,
                        items: classes.map((cls) {
                          return DropdownMenuItem(
                            value: cls,
                            child: Text(cls),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => cls = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration:
                            textInputDecoration.copyWith(hintText: "Kingdom"),
                        onChanged: (value) {
                          setState(() {
                            kingdom = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: "Description"),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Add a Fish',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
//                    loading = true;
                            });
                            try {
                              dynamic result = await dbService().addFishData(
                                  scientificName,
                                  commonName,
                                  description,
                                  kingdom,
                                  cls,
                                  len);
                              print(result);
                              if (result == null) {
                                //successful pop up
//                              _formkey.currentState.reset();
//                              Navigator.of(context).pop();
                                print('accessed');
                                _showSuccessPopUp();
                              }
                            } catch (e) {
                              setState(() {
                                _showErrorPopUp(e);
//                              loading = false;
                              });
                              //error pop server failure
                              print(e);
                            }
                          }
                        },
                      ),
                      SizedBox(height: 15.0),
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
            ),
          ],
        ));
  }
}
