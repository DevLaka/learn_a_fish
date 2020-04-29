import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';

class FishUpdateForm extends StatefulWidget {
  final Fish fish;
  FishUpdateForm({this.fish});

  @override
  _FishUpdateFormState createState() => _FishUpdateFormState();
}

class _FishUpdateFormState extends State<FishUpdateForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> classes = ['cls a', 'cls b', 'cls c'];

  String _currentComName;
  String _currentClass;
  int _currentLen;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Fish>>.value(
      value: dbService().fishStream,
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Text(
              'Update the Fish',
              style: TextStyle(fontSize: 17.0),
            ),
            SizedBox(height: 17.0),
            TextFormField(
              initialValue: widget.fish.comName,
              decoration: textInputDecoration,
              validator: (value) =>
                  value.isEmpty ? "Please enter valid name" : null,
              onChanged: (value) => setState(() => _currentComName = value),
            ),
            SizedBox(height: 17.0),
            //dropdown
            DropdownButtonFormField(
              decoration: textInputDecoration,
              value: _currentClass ?? widget.fish.cls,
              items: classes.map((cls) {
                return DropdownMenuItem(
                  value: cls,
                  child: Text(cls),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentClass = val),
            ),
            //slider
            Slider(
              label: "Length",
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
            //button
            RaisedButton(
                color: Colors.pinkAccent[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    await dbService().updateSingleFishData(
                      widget.fish.docID,
                      widget.fish.scName,
                      _currentComName ?? widget.fish.comName,
                      widget.fish.description,
                      widget.fish.kingdom,
                      _currentClass ?? widget.fish.cls,
                      _currentLen ?? widget.fish.len,
                    );
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
    );
  }
}
