import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';

class FishUpdateForm extends StatefulWidget {
  @override
  _FishUpdateFormState createState() => _FishUpdateFormState();
}

class _FishUpdateFormState extends State<FishUpdateForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> classes = ['class a', 'class b', 'class c'];

  String _currentComName;
  String _currentClass;
  int _len;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          Text(
            'Update the Fish',
            style: TextStyle(fontSize: 17.0),
          ),
          SizedBox(height: 17.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (value) => value.isEmpty ? "Please enter valid name" : null,
            onChanged: (value) => setState(() => _currentComName = value),
          ),
          SizedBox(height: 17.0),
          //dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentClass ?? 'class a',
            items: classes.map((cls){
              return DropdownMenuItem(
                value: cls,
                child: Text(cls),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentClass = val),
          ),
          //slider
          //button
          RaisedButton(
            color: Colors.pinkAccent[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentComName);
              print(_currentClass);
              print(_len);
            },
          )
        ],
      ),
    );
  }
}
