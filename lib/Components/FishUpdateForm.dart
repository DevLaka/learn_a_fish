import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FishUpdateForm extends StatefulWidget {
  final Fish fish;
  FishUpdateForm({this.fish});

  @override
  _FishUpdateFormState createState() => _FishUpdateFormState();
}

class _FishUpdateFormState extends State<FishUpdateForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> classes = ['cls a', 'cls b', 'cls c'];

  String imageUrl;
  File image;
  String _currentComName;
  String _currentClass;
  String _currentScientificName;
  String _currentKingdom;
  String __currentDesc;
  int _currentLen;

  @override
  void initState() {
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(widget.fish.docID);
    firebaseStorageReference
        .getDownloadURL()
        .then((loc) => setState(() => imageUrl = loc));
    super.initState();
  }

  void updateImageUrl() {
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(widget.fish.docID);
    firebaseStorageReference
        .getDownloadURL()
        .then((loc) => setState(() => imageUrl = loc));
  }

  Future<bool> _showCameraDialog() {
    return Alert(context: context, title: "Choose a mode", buttons: [
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

  _useGallery() async {
    var choseImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      image = choseImage;
      print(image);
      print(image.path.toString());
    });
  }

  _useCamera() async {
    var choseImage = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      image = choseImage;
    });
  }

  Future uploadImage(BuildContext context, id) async {
    String imageFileName = id;
    print(imageFileName);
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask imageUploadTask = firebaseStorageReference.putFile(image);
    StorageTaskSnapshot imageTaskSnapshot = await imageUploadTask.onComplete;
    setState(() {
      print('picture uploaded');
      print(imageTaskSnapshot.storageMetadata.toString());
//      updateImageUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.fish.docID;
    return StreamProvider<List<Fish>>.value(
      value: dbService().fishStream,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Container(
                width: 250.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(18.0),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Center(
                  child: Text(
                    'Update the Fish',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: SizedBox(
                  width: 220.0,
                  height: 160.0,
                  child: (image == null)
                      ? (imageUrl == null)
                          ? Image.asset(
                              'assets/nemo.png',
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              imageUrl,
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
                    width: 100.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
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
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                    height: 50.0,
                    width: 100.0,
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
                        uploadImage(context, id);
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
                height: 25.0,
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                initialValue: widget.fish.comName,
                decoration: newTextInputDecoration.copyWith(
                  labelText: "Common Name",
                  prefixIcon: Icon(
                    Icons.input,
                    color: Colors.white,
                  ),
                ),
                validator: (value) =>
                    value.isEmpty ? "Please enter valid common name" : null,
                onChanged: (value) => setState(() => _currentComName = value),
              ),
              SizedBox(height: 17.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                initialValue: widget.fish.scName,
                decoration: newTextInputDecoration.copyWith(
                  labelText: "Scientific Name",
                  prefixIcon: Icon(
                    Icons.input,
                    color: Colors.white,
                  ),
                ),
                validator: (value) =>
                    value.isEmpty ? "Please enter scientific name" : null,
                onChanged: (value) =>
                    setState(() => _currentScientificName = value),
              ),
              SizedBox(height: 17.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                initialValue: widget.fish.kingdom,
                decoration: newTextInputDecoration.copyWith(
                  labelText: "Kingdom",
                  prefixIcon: Icon(
                    Icons.input,
                    color: Colors.white,
                  ),
                ),
                validator: (value) =>
                    value.isEmpty ? "Please enter kingdom name" : null,
                onChanged: (value) => setState(() => _currentKingdom = value),
              ),
              SizedBox(height: 17.0),
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
                  value: _currentClass ?? widget.fish.cls,
                  items: classes.map((cls) {
                    return DropdownMenuItem(
                      value: cls,
                      child: Text(cls),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentClass = val),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  maxLines: 5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  initialValue: widget.fish.description,
                  decoration: newTextInputDecoration.copyWith(
                    labelText: "Description",
                    prefixIcon: Icon(
                      Icons.input,
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Please enter a valid description" : null,
                  onChanged: (value) => setState(() => __currentDesc = value),
                ),
              ),
              SizedBox(height: 17.0),
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
                        label: '${(_currentLen ?? widget.fish.len).toDouble()}',
                        value: (_currentLen ?? widget.fish.len).toDouble(),
                        min: 1,
                        max: 100,
                        divisions: 50,
                        onChanged: (value) {
                          setState(() {
                            _currentLen = value.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //button
              Container(
                height: 50.0,
                width: 250.0,
                margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
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
                      'Update',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await dbService().updateSingleFishData(
                          widget.fish.docID,
                          _currentScientificName ?? widget.fish.scName,
                          _currentComName ?? widget.fish.comName,
                          __currentDesc ?? widget.fish.description,
                          _currentKingdom ?? widget.fish.kingdom,
                          _currentClass ?? widget.fish.cls,
                          _currentLen ?? widget.fish.len,
                        );
                        Navigator.pop(context);
                      }
                    }),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
