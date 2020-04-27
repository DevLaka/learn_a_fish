import 'package:flutter/material.dart';
import 'package:learnafish/services/db.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_box,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/userManagement');
            },
          ),
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async{
            try{
              await dbService().updateFishData('sceintific name a', 'common name a', 'descirption a', 'kingdom a', ' a', 'family a', 'cls a');
            }catch(e){

            }

          },
          child: Text(
            'Add',
          ),
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
