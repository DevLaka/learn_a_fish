import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File image;

  String commonName = "";
  String scientificName = "";
  String family = "";
  String kingdom = "";
  String phylum = "";
  String description = "";
  String error = "";
  String cls = "cls a";
  int len = 1;

  _useGallery() async{
    var choseImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      image = choseImage;
    }
    );
  }

  _useCamera() async{
    var choseImage = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      image = choseImage;
    }
    );
  }

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

    Future<bool> _showCameraDialog() {
      return Alert(
          context: context,
          title: "Choose a mode",
          buttons: [
            DialogButton(
              child: Text('Camera'),
              onPressed: () async {
                await _useCamera();
              },
            ),
            DialogButton(
              child: Text('Gallery'),
              onPressed: () async {
               await _useGallery();
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
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
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
                      //camera and gallery selection
                      Text("No image selected"),
                      RaisedButton(
                        onPressed: () {
                          _showCameraDialog();
                        },
                        child: Text('Select Image'),
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) =>
                        value.isEmpty ? "This cannot be empty" : null,
                        decoration: newTextInputDecoration.copyWith(
                          labelText: "Common Name",
                          prefixIcon: Icon(
                            Icons.input,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            commonName = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: newTextInputDecoration.copyWith(
                          labelText: "Scientific Name",
                          prefixIcon: Icon(
                            Icons.input,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            scientificName = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.black87,
                          textTheme: TextTheme(
                            body1: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: DropdownButtonFormField(
                          decoration: newTextInputDecoration.copyWith(
                            labelText: "Class",
                            prefixIcon: Icon(
                              Icons.input,
                              color: Colors.white,
                            ),
                          ),
                          value: cls,
                          items: classes.map((cls) {
                            return DropdownMenuItem(
                              value: cls,
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Text(cls),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => cls = val),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: newTextInputDecoration.copyWith(
                          labelText: "Kingdom",
                          prefixIcon: Icon(
                            Icons.input,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            kingdom = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) =>
                            value.isEmpty ? "This cannot be empty" : null,
                        decoration: newTextInputDecoration.copyWith(
                          labelText: "Description",
                          prefixIcon: Icon(
                            Icons.input,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(18.0),
                          color: Colors.black45,
                        ),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Length of the Fish in Centi-meters',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbColor: Colors.lightBlueAccent,
                                trackHeight: 4.0,
                                activeTrackColor: Colors.blue,
                                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Colors.indigo,
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: Slider(
                                label: '${(len).toDouble()}',
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
                          ],
                        ),
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
                          child: Text(
                            'Add a Fish',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
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
