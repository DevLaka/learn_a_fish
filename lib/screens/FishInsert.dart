/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This class is responsible inserting a fish document in the firebase fireStore, connecting to the      *
/// camera, selecting photo from gallery, taking a photo using camera, uploading the photo to the firebase Storage,    *
/// form validation, success and error popups.                                                                         *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/FishDBService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FishInsert extends StatefulWidget {
  @override
  _FishInsertState createState() => _FishInsertState();
}

class _FishInsertState extends State<FishInsert> {
  final _formKey = GlobalKey<FormState>(); // FormKey associated with form used for form validation

  // List of fish classes that will be assigned to dropDown
  final List<String> classes = [
    'Superclass Agnatha',
    'chondrichthyes',
    'osteichthyes'
  ];


  File image; // Stores the image fie that will be uploaded
  String id = DateTime.now().toIso8601String(); // Generates a unique id for fish document
  String commonName = "";
  String scientificName = "";
  String family = "";
  String kingdom = "";
  String description = "";
  String error = "";
  String cls = "Superclass Agnatha"; // Class of the fish
  int len = 1; // Length of the fish

  // ignore: slash_for_doc_comments
  /**
   * @description Picking up the image by gallery mode using ImagePicker package
   */
  _useGallery() async {
    var choseImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      image = choseImage;
      print(image);
      print(image.path.toString());
    });
  }

  // ignore: slash_for_doc_comments
  /**
   * @description Picking up the image by camera mode using ImagePicker package
   */
  _useCamera() async {
    var choseImage = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      image = choseImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    /**
     * @description PopUp after inserting the fish mentioning whether the operation is successful or not
     * In this popup two options are given whether to add another fish or view fish list
     */
    Future<bool> _showSuccessPopUp() {
      return Alert(
          context: context,
          title: "Insert Sucessful",
          desc: "Your Fish is sucessfully inserted to NEMO",
          image: Image.asset("assets/success-alert.png"),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment(0.9, 0.0),
                colors: [Colors.blueAccent, Colors.indigo],
              ),
              child: Text('Add another fish',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            DialogButton(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment(0.9, 0.0),
                colors: [Colors.blueAccent, Colors.indigo],
              ),
              child: Text('View Fish List',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ]).show();
    }

    /**
     * @description Shows the popUp to choose the mode between camera or gallery
     */
    Future<bool> _showCameraDialog() {
      return Alert(context: context, title: "Choose a method", buttons: [
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, 0.0),
            colors: [Colors.blueAccent, Colors.indigo],
          ),
          child: Text(
            'Camera',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            await _useCamera();
          },
        ),
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, 0.0),
            colors: [Colors.blueAccent, Colors.indigo],
          ),
          child: Text(
            'Gallery',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            await _useGallery();
          },
        ),
      ]).show();
    }

    /**
     * @description Shows the popUp with the error if the insertion fails
     * @param e - generated error message
     */
    Future<bool> _showErrorPopUp(Error e) {
      return Alert(
          context: context,
          title: "Insert UnSucessful",
          desc: "Insertion Faile! Nemo feels Sorry!",
          image: Image.asset("assets/error-alert.png"),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment(0.9, 0.0),
                colors: [Colors.blueAccent, Colors.indigo],
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]).show();
    }

    /**
     * @description Uploads the Image to the firebase Storage.
     * @param context - current build context
     * @param id - id of the fish document
     * Reference : https://youtu.be/7uqmY6le4xk
     */
    Future uploadImage(BuildContext context) async {
      String imageFileName = id;
      print(imageFileName);
      StorageReference firebaseStorageReference =
          FirebaseStorage.instance.ref().child(imageFileName);
      StorageUploadTask imageUploadTask =
          firebaseStorageReference.putFile(image);
      StorageTaskSnapshot imageTaskSnapshot = await imageUploadTask.onComplete;
      setState(() {
        print(imageTaskSnapshot.storageMetadata.toString());
      });
    }

    return Stack(
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
            title: Text('Add a Fish'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: SingleChildScrollView(
              // Fish insert form
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 260.0,
                        height: 220.0,
                        child: (image == null)
                            ? Image.asset(
                                'assets/nemo.png',
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 17.0,
                    ),
                    //camera and gallery selection
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 130.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 12.0),
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
                            onPressed: () {
                              _showCameraDialog();
                            },
                            child: Text(
                              'Select Image',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 20.0),
                          height: 50.0,
                          width: 130.0,
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
                            onPressed: () {
                              uploadImage(context);
                            },
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.0,
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
                              valueIndicatorShape:
                                  PaddleSliderValueIndicatorShape(),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
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
                          if (_formKey.currentState.validate()) {
                            setState(() {});
                            try {
                              dynamic result = await FishDBService().addFishData(
                                id,
                                scientificName,
                                commonName,
                                description,
                                kingdom,
                                cls,
                                len,
                              );
                              print(result);
                              if (result == null) {
                                //successful pop up
                                _formKey.currentState.reset();
                                print('accessed');
                                _showSuccessPopUp();
                              }
                            } catch (e) {
                              setState(() {
                                _showErrorPopUp(e);
                              });
                              //error popup server failure
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
        ),
      ],
    );
  }
}
