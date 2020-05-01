import 'package:flutter/material.dart';
import 'package:learnafish/models/Fish.dart';

class FishView extends StatelessWidget {
  final Fish fish;
  FishView({this.fish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text(
            fish.comName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('assets/nemo.jpg'),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 30.0,
                    thickness: 2.0,
                  ),
                  Text(
                    'Common Name',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.comName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 17.0),
                  Text(
                    'Scientific Name',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.scName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 17.0),
                  Text(
                    'Kingdom',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.kingdom,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 17.0),
                  Text(
                    'Class',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.cls,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 17.0),
                  Text(
                    'Length in CM s',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.len.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 17.0),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    fish.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
