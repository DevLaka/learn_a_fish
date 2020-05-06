import 'package:flutter/material.dart';
import 'package:learnafish/models/Fish.dart';

class FishView extends StatelessWidget {
  final Fish fish;
  final String imageUrl;
  FishView({this.fish, this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.transparent,
              title: Text(
                fish.comName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 220.0,
                        child: (imageUrl == null)
                            ? Image.asset(
                                'assets/nemo.png',
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 30.0,
                      thickness: 2.0,
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Common Name',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.comName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Scientific Name',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.scName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Kingdom',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.kingdom,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Class',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.cls,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Length in CM s',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.len.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[100],
                      margin: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Text(
                          fish.description,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 17.0),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
