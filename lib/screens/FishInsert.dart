import 'package:flutter/material.dart';
import 'package:learnafish/Components/Constants.dart';
import 'package:learnafish/services/db.dart';

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
                )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value) => value.isEmpty ? "This cannot be empty" : null,
                      decoration: textInputDecoration.copyWith(hintText: "Common Name"),
                      onChanged: (value) {
                        setState(() {
                          commonName = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value) => value.isEmpty ? "This cannot be empty" : null,
                      decoration: textInputDecoration.copyWith(hintText: "Scientific Name"),
                      onChanged: (value) {
                        setState(() {
                          scientificName = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
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
                    SizedBox(height: 20.0,),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: cls,
                      items: classes.map((cls){
                        return DropdownMenuItem(
                          value: cls,
                          child: Text(cls),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => cls = val),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value) => value.isEmpty ? "This cannot be empty" : null,
                      decoration: textInputDecoration.copyWith(hintText: "Kingdom"),
                      onChanged: (value) {
                        setState(() {
                          kingdom = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value) => value.isEmpty ? "This cannot be empty" : null,
                      decoration: textInputDecoration.copyWith(hintText: "Description"),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Add a Fish',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                if(_formkey.currentState.validate()){
                  setState(() {
//                    loading = true;
                  });
                  dynamic result = await dbService().updateFishData(scientificName, commonName, description, kingdom, cls, len);
                  print(result);
                  if(result != null){
                    setState(() {
                      error = 'Error adding the fish';
//                      loading = false;
                    });
                  }
                }
                _formkey.currentState.reset();
                Navigator.of(context).pop();
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
          ),
        ],
      )
    );
  }
}
